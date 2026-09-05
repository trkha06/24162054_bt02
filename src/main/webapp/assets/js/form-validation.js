(() => {
    'use strict';

    const MAX_UPLOAD_SIZE = 10 * 1024 * 1024;

    const validateField = (field) => {
        if (field.required && !['checkbox', 'radio', 'file'].includes(field.type)
                && field.value.trim() === '') {
            field.setCustomValidity('Vui lòng nhập thông tin bắt buộc.');
        } else if (field.type === 'file' && field.files.length > 0
                && field.files[0].size > MAX_UPLOAD_SIZE) {
            field.setCustomValidity('Tệp tải lên không được vượt quá 10 MB.');
        } else {
            field.setCustomValidity('');
        }
    };

    const validatePasswordConfirmation = (form) => {
        const confirmation = form.querySelector('[data-match-password]');
        if (!confirmation) return;

        const password = form.querySelector(confirmation.dataset.matchPassword);
        confirmation.setCustomValidity(password && confirmation.value !== password.value
            ? 'Mật khẩu xác nhận không khớp.' : '');
    };

    document.addEventListener('input', (event) => {
        const field = event.target;
        if (field.matches('.needs-validation input, .needs-validation select, .needs-validation textarea')) {
            validateField(field);
            if (field.form) validatePasswordConfirmation(field.form);
        }
    });

    document.addEventListener('change', (event) => {
        const field = event.target;
        if (field.matches('.needs-validation input[type="file"]')) validateField(field);
    });

    document.addEventListener('submit', (event) => {
        const form = event.target;
        if (!form.matches('.needs-validation')) return;

        form.querySelectorAll('input, select, textarea').forEach(validateField);
        validatePasswordConfirmation(form);
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    }, true);
})();
