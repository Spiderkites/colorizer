
import { isMobile } from './../helpers.js'

const productImages		 = '#gallery img'
const productImagesModal = '#gallery_preview img'
const imageModal		 = '#productImagesModal'

const $document			 = $(document)
const $productImages	 = $(productImages)

$document.on('click', productImages, function () {
    if (isMobile()) {
        $(imageModal).modal('show');
        $(imageModal).on('shown.bs.modal', () => {
            $(imageModal + ' img[data-index="' + $(this).data('index') + '"]')[0].scrollIntoView({
                behavior: 'smooth',
                block: 'center'
            });
        });
    }
});
