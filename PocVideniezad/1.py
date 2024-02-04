import cv2
import numpy as np
from skimage import morphology

lower_red1 = np.array([0, 70, 50])
upper_red1 = np.array([10, 255, 255])
lower_red2 = np.array([170, 70, 50])
upper_red2 = np.array([180, 255, 255])

def is_red_car(image, contour):
    # Create a mask for the contour
    mask = np.zeros_like(image[:, :, 0])
    cv2.drawContours(mask, [contour], -1, color=255, thickness=cv2.FILLED)

    # Convert to HSV color space
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

    # Mask the area of the contour and apply the red color mask
    masked_image = cv2.bitwise_and(hsv_image, hsv_image, mask=mask)

    # Check for red color within the contour
    red_mask1 = cv2.inRange(masked_image, lower_red1, upper_red1)
    red_mask2 = cv2.inRange(masked_image, lower_red2, upper_red2)
    full_red_mask = red_mask1 | red_mask2

    # If there's enough red pixels, consider it a red car
    return np.sum(full_red_mask) > 100  # Threshold for what you consider enough red

# Open the video file
cap = cv2.VideoCapture('traffic_small_small.mp4')
if not cap.isOpened():
    print("Error opening video file.")
    exit()

# Get video properties
frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
fps = cap.get(cv2.CAP_PROP_FPS)

# Define the codec and create VideoWriter object to save the video
out = cv2.VideoWriter('processed_video.avi', cv2.VideoWriter_fourcc('M','J','P','G'), fps, (frame_width, frame_height))

backSub = cv2.createBackgroundSubtractorMOG2()

# Resize factor
resize_factor = 1

while True:
    ret, frame = cap.read()
    if not ret:
        break

    # Resize the frame to speed up processing
    small_frame = cv2.resize(frame, None, fx=resize_factor, fy=resize_factor)

    # Apply background subtraction on the smaller frame
    fgMask = backSub.apply(small_frame)
    fgMask = cv2.morphologyEx(fgMask, cv2.MORPH_OPEN, np.ones((3, 3), np.uint8))
    fgMask = fgMask > 127
    fgMask = fgMask.astype('uint8') * 255
    fgMask = morphology.remove_small_holes(fgMask.astype(bool), area_threshold=1000)
    fgMask = fgMask.astype('uint8') * 255
    fgMask = cv2.dilate(fgMask, np.ones((10, 10)), iterations=3)

    contours, _ = cv2.findContours(fgMask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    dot_size = 5  # Dot size for normal cars
    red_dot_size = 30 # Dot size for red cars (or first detected car for demonstration)

    for contour in contours:
        M = cv2.moments(contour)
        if M['m00'] != 0:
            cx = int(M['m10'] / M['m00'])
            cy = int(M['m01'] / M['m00'])

            # Check if the detected car is red
            if is_red_car(frame, contour):
                # If it's a red car, use a larger dot size
                dot_size = red_dot_size
                dot_color = (0, 0, 255)  # Red color for red cars
            else:
                dot_size = dot_size
                dot_color = (0, 255, 0)  # Green color for other cars

            # Draw the dot on the frame
            cv2.circle(frame, (cx, cy), dot_size, dot_color, -1)

    # Resize the processed frame back to the original size for visualization
    processed_frame = cv2.resize(small_frame, (frame_width, frame_height))

    # Write the frame into the file 'processed_video.avi'
    out.write(processed_frame)

    # Display the processed frame
    cv2.imshow('Video', processed_frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release everything when job is finished
cap.release()
out.release()
cv2.destroyAllWindows()
