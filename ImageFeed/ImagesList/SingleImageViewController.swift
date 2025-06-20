import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
            if let image = image {
                rescaleAndCenterImageInScrollView(image: image)
            }
        }
    }
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroll()
        imageView.image = image
        imageHeight.constant = imageView.image?.size.height ?? 0
        imageWidth.constant = imageView.image?.size.width ?? 0
        if let image = image {
            rescaleAndCenterImageInScrollView(image: image)
        }
    }
    
    func setupScroll() {
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sharingButton(_ sender: Any) {
        guard let image = imageView.image else {
            return
    }
    
    
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
    }
    
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        view.layoutIfNeeded()
        
        // Размеры экрана и фотки
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        
        // Минимальный и максимальный масштаб
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        
        // Вычисляем масштаб
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = max(minZoomScale, min(maxZoomScale, max(hScale, vScale)))
        
        // Устанавливаем масштаб
        scrollView.setZoomScale(scale, animated: false)
        
        // Убеждаемся, что layout обновился после изменения масштаба
        scrollView.layoutIfNeeded()
        
        let newContentSize = scrollView.contentSize
        
        let horizontalInset = max(0, (newContentSize.width) / 2)
        let verticalInset = max(0, (newContentSize.height) / 2)
        // Добавляем inset
        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        )
        // Высчитываем центр
        let xOffset = max(0, (newContentSize.width - visibleRectSize.width) / 2)
        let yOffset = max(0, (newContentSize.height - visibleRectSize.height) / 2)
        // Устанавливаем центр
        scrollView.contentOffset = CGPoint(x: xOffset, y: yOffset)
    }
}


