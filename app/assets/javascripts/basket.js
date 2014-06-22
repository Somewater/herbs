function add_callback_to_basket_bnts(){
    $('.basket-btn').on('click', function(event){
        var btn = $(event.currentTarget)
        var action = btn.data('action')
        var render = !!btn.data('render')
        if(action == 'add'){
            $.get(Herbs.basket_add, {product_id: btn.data('product-id'),cost_id: btn.data('cost-id'),quantity:1,render: render}, function(response){
                $('#basket-menu-item').addClass('alert-info')
                if(render) render_basket(response.body)
                render_mini_basket(response.mini_basket)
            });
            event.preventDefault()
        } else if(action == 'remove') {
            $.get(Herbs.basket_remove, {product_id: btn.data('product-id'),cost_id: btn.data('cost-id'),quantity:1,render: render}, function(response){
                if(render) render_basket(response.body)
                render_mini_basket(response.mini_basket)
            });
        } else if(action == 'clear') {
            $.get(Herbs.basket_clear, {render: render}, function(response){
                $('#basket-menu-item').removeClass('alert-info')
                if(render) render_basket(response.body)
                render_mini_basket(response.mini_basket)
            });
        }
    })
}
function init_basket_btn_block(){
    var block = $('#basket-btn-block')
    if(block && block.length > 0) {
        set_selected_costs_index(Herbs.product_selected_cost_idx)
        $('#basket-block-btn', block).on('click', function(event){
            var cost = Herbs.product_costs[Herbs.product_selected_cost_idx];
            var quantity = parseInt($('#basket-btn-block input[type=text]').val());
            if(isNaN(quantity) || quantity < 1 || quantity > 99) quantity = 1;
            $.get(Herbs.basket_add, {product_id: Herbs.product.id,cost_id: cost.id,quantity:quantity,render: false}, function(response){
                console.log('ok')
            });
            event.preventDefault()
        })
        $('.plus', block).on('click', function(event){
            Herbs.product_selected_cost_idx = Math.min(Herbs.product_selected_cost_idx + 1, Herbs.product_costs.length - 1)
            set_selected_costs_index(Herbs.product_selected_cost_idx)
            event.preventDefault()
        })
        $('.minus', block).on('click', function(event){
            Herbs.product_selected_cost_idx = Math.max(Herbs.product_selected_cost_idx - 1, 0)
            set_selected_costs_index(Herbs.product_selected_cost_idx)
            event.preventDefault()
        })
    }
}
function set_selected_costs_index(index){
    var selected_cost = Herbs.product_costs[index];
    if (selected_cost) {
        var block = $('#basket-btn-block')
        $('#cost-tablo', block).html('<strong>' + (selected_cost.cost || 0).toString() + ' р.</strong> / ' + (selected_cost.amount || 0).toString() + ' гр.')
    }
}
function render_basket(basket_html){
    $('#basket-show').html(basket_html)
    add_callback_to_basket_bnts()
}
function render_mini_basket(text){
    $('#mini_basket').text(text)
}
$(function(){
    add_callback_to_basket_bnts();
    init_basket_btn_block();
})