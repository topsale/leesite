var Loader = function () {
    var loading = function () {
        // 页面加载时
        $(window).load(function() {
            $("#loading").fadeOut(500);
        });
    };

    return {
        init: function () {
            loading();
        }
    };
}();

jQuery(document).ready(function () {
    $("body").append(
        '<div id="loading">' +
            '<div id="loading-center">' +
                '<div id="loading-center-absolute">' +
                    '<div id="object"></div>' +
                '</div>' +
            '</div>' +
        '</div>'
    );

    Loader.init();
});