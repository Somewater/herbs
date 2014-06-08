$(function(){
    $('#price-sort').on('change', function(e){
        $.get(Herbs.section_show, {sort: $(this).val()}, function(response){
            $('#products-collection').html(response)
        })
    })
})