$.jMaskGlobals.watchDataMask = true;
$(".phone-number").mask('+7 000 000-00-00');

$(function() {
    $('.datetimepicker').each(function() {
        var options = {};
        options['useCurrent'] = false;
        if (this.getAttribute('datepicker')) {
            options['format'] = 'L';
        }
        if (this.getAttribute('timepicker')) {
            options['format'] = 'LT';
        }
        if (this.defaultValue) {
            options['date'] = this.defaultValue;
        }
        if (this.dataset['linkedWith']) {
            options['useCurrent'] = false;
        }
        $(this).datetimepicker(options);
    })

    $('#add_topic').on('click', function () {
        addTopic($('#topic_picker').val())
        $('#topic_picker').val('');
    });

    function addTopic(topic) {
        if (topic.length >0) {
            current_value = $('#event_topics').val();

            $('#event_topics').val(current_value + topic);
        }
    }
})
