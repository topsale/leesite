/**
 * 选择框表格
 * Created by Lusifer on 2017/3/20.
 */
var CheckTable = function () {
    var initCheckTable = function() {
        $("table").each(function () {
            $(this).find('.group-checkable').change(function () {
                var set = jQuery(this).attr("data-set");
                var checked = jQuery(this).is(":checked");
                jQuery(set).each(function () {
                    if (checked) {
                        $(this).prop("checked", true);
                        $(this).parents('tr').addClass("active");
                    } else {
                        $(this).prop("checked", false);
                        $(this).parents('tr').removeClass("active");
                    }
                });
            });

            $(this).on('change', 'tbody tr .checkboxes', function () {
                $(this).parents('tr').toggleClass("active");
            });
        });
    };

    return {
        init: function () {
            initCheckTable();
        }
    }
}();
