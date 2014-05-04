function add_callback_to_basket_bnts(){
    $('.basket-btn').on('click', function(event){
        var btn = $(event.currentTarget)
        var action = btn.data('action')
        var render = !!btn.data('render')
        if(action == 'add'){
            $.get(Herbs.basket_add, {product_id: btn.data('product-id'),cost_id: btn.data('cost-id'),quantity:1,render: render}, function(response){
                $('#basket-menu-item').addClass('alert-info')
                if(render) render_basket(response)
            });
        } else if(action == 'remove') {
            $.get(Herbs.basket_remove, {product_id: btn.data('product-id'),cost_id: btn.data('cost-id'),quantity:1,render: render}, function(response){
                if(render) render_basket(response)
            });
        } else if(action == 'clear') {
            $.get(Herbs.basket_clear, {render: render}, function(response){
                $('#basket-menu-item').removeClass('alert-info')
                if(render) render_basket(response)
            });
        }
    })
}
function render_basket(basket_html){
    $('#content').html(basket_html)
    add_callback_to_basket_bnts()
}
$(add_callback_to_basket_bnts)