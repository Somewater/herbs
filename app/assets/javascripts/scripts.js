$(document).ready(function(){

// Карусель
    if ($('#caruselWindow ul li').size() <= 5) {
        $('.r_point').hide()
        $('.l_point').hide()
    } else {
    var timeSlide = 300;                            // время листания слайда
        $('.r_point').click(function(){
            $('#caruselWindow ul')
                .animate({'marginLeft':'-172px'},timeSlide,function(){
                    var x = $('#caruselWindow ul li:first');
                    $('#caruselWindow ul').append(x).css('marginLeft','0');
                })
        })

        $('.l_point').click(function(){
            var x = $('#caruselWindow ul li:last');
            $('#caruselWindow ul').prepend(x).css('marginLeft','-172px');
            $('#caruselWindow ul')
                .animate({'marginLeft':'0'},timeSlide)
        })
    }


// Разворачивание меню
    var timeApp = 400;                          // время разворачивания меню
    var p_height = $('.app_info p').height();
    $('.buttn').toggle(function(e){
        e.preventDefault();
        $('.app_info p').animate({'height':'0'},timeApp,function(){
            $('.app_info p').css('display','none')
            $('.buttn').attr('src','/assets/images/log_vee.png')
        });
    },function(ee){
        if(ee) ee.preventDefault();
        $('.app_info p').css('display','inline-block')
        $('.app_info p').animate({'height':p_height},timeApp,function(){
            $('.buttn').attr('src','/assets/images/log_wedge.png')
        });
    })


// Смена фона
    var timeInterval = 4000;        // промежуток между слайдами
    var timeFade = 2000;            // время слайда
    function bg_app(adress, anim, holder_id){
        $('#bgcontent' + holder_id).css({'opacity':'0', 'background-image':'url("' + adress + '")'}).animate({'opacity':'1'},timeFade)
    }
    function bg_disapp(adress, holder_id){
        $('#bgcontent' + holder_id).css({'opacity':'1', 'background-image':'url("' + adress + '")'}).animate({'opacity':'0'},timeFade)
    }
    var bg_images = Herbs.main_page_pictures;
    var cur_image = -1;
    var cur_holder_id = -1
    var bg_anim = function() {
        var anim = cur_image != -1
        cur_holder_id += 1
        var holder_id = (cur_holder_id % 2) + 1
        cur_image += 1
        var img = bg_images[cur_image % bg_images.length]
        bg_app(img, anim, holder_id);
        setTimeout(function(){bg_disapp(img, holder_id)},timeInterval + timeFade);
    }
    if (bg_images.length > 0) {
        setInterval(bg_anim,timeInterval + timeFade)
        bg_anim()
    }
})