/**
 * Created by Lusifer on 2017/5/2.
 */
var LoadPace = function () {
    var loading = function () {
        paceOptions = {
            document: true
        };

        Pace.start();
    };

    return {
        init: function () {
            loading();
        }
    };
}();

jQuery(document).ready(function () {
    LoadPace.init();
});