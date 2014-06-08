$(function(){
    $('#price-sort').on('change', function(e){
        $.get(Herbs.section_show, {sort: $(this).val(), page: Herbs.section_page}, function(response){
            $('#products-collection').html(response)
        })
    })
})