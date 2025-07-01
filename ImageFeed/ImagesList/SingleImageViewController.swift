import UIKit

final class SingleImageViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Public Properties
    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
            if let image = image {
                updateImageViewFrame(for: image)
                rescaleAndCenterImageInScrollView(image: image)
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        setupScroll()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = true // используем frame напрямую
        imageView.image = image
        
        if let image = image {
            updateImageViewFrame(for: image)
            rescaleAndCenterImageInScrollView(image: image)
        }
    }
    
    // MARK: - Setup
    private func setupScroll() {
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sharingButton(_ sender: Any) {
        guard let image = imageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    // MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK: - Helpers
    private func updateImageViewFrame(for image: UIImage) {
        imageView.frame = CGRect(origin: .zero, size: image.size)
        scrollView.contentSize = image.size
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        view.layoutIfNeeded()
        
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = max(minZoomScale, min(maxZoomScale, max(hScale, vScale)))
        
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        
        let scaledImageSize = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)
        
        let horizontalInset = max(0, (visibleRectSize.width - scaledImageSize.width) / 2)
        let verticalInset = max(0, (visibleRectSize.height - scaledImageSize.height) / 2)
        
        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        )
    }
}

