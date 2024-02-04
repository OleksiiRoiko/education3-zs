import matplotlib.pyplot as plt
import numpy as np
from skimage import io, color, filters
from skimage.filters import gabor
from skimage.segmentation import watershed
from skimage.util import img_as_ubyte
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler


def load_and_preprocess_image(image_path):
    image = io.imread(image_path, as_gray=True)
    image = img_as_ubyte(image)
    smoothed_image = filters.gaussian(image, sigma=1)
    # Visualize the preprocessed image
    plt.figure()
    plt.imshow(smoothed_image, cmap='gray')
    plt.title('Preprocessed Image')
    plt.axis('off')
    plt.show()
    return image, smoothed_image


def apply_gabor_filters(image, frequencies, thetas):
    num_features = len(frequencies) * len(thetas)
    feature_array = np.zeros((image.shape[0], image.shape[1], num_features))
    feature_index = 0
    for frequency in frequencies:
        for theta in thetas:
            real, imag = gabor(image, frequency=frequency, theta=theta)
            magnitude = np.sqrt(real ** 2 + imag ** 2)
            feature_array[:, :, feature_index] = magnitude
            feature_index += 1

    return feature_array


def compute_feature_gradient(feature_array):
    # feature_variance = np.var(feature_array, axis=2)
    feature_std = np.std(feature_array, axis=2)

    feature_gradient = (feature_std - feature_std.min()) / (feature_std.max() - feature_std.min())

    plt.figure()
    plt.imshow(feature_gradient, cmap='gray')
    plt.title('Feature Gradient')
    plt.axis('off')
    plt.show()

    return feature_gradient


def perform_clustering(feature_array):
    feature_vectors = feature_array.reshape(-1, feature_array.shape[2])
    scaler = StandardScaler()
    features_scaled = scaler.fit_transform(feature_vectors)
    kmeans = KMeans(n_clusters=4, n_init='auto', random_state=0)
    labels = kmeans.fit_predict(features_scaled).reshape(feature_array.shape[0], feature_array.shape[1])
    # Visualize clustering output
    plt.figure()
    plt.imshow(labels)
    plt.title('K-Means Clustering Output')
    plt.axis('off')
    plt.show()
    return labels


def apply_watershed_segmentation(image, feature_array, labels):
    # Compute the feature gradient instead of using the image gradient
    feature_gradient = compute_feature_gradient(feature_array)

    # Use the feature gradient as an elevation map for the watershed algorithm
    labels_watershed = watershed(feature_gradient, markers=labels, mask=image > 0)
    return labels_watershed


def visualize_segmentation(image, labels_watershed):
    plt.figure()
    plt.imshow(color.label2rgb(labels_watershed, image=image, bg_label=0))
    plt.title('Final Segmentation')
    plt.axis('off')
    plt.show()


def main():
    image_path = 'data/tm2_1_1.png'  # Replace with the correct path to your image
    image, smoothed_image = load_and_preprocess_image(image_path)
    frequencies = np.linspace(0.1, 5, 20)
    thetas = np.linspace(0, 4 * np.pi, 20)
    feature_array = apply_gabor_filters(smoothed_image, frequencies, thetas)
    labels = perform_clustering(feature_array)
    labels_watershed = apply_watershed_segmentation(image, feature_array, labels)
    visualize_segmentation(image, labels_watershed)


if __name__ == '__main__':
    main()
