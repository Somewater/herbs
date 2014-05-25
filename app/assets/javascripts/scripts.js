$(document).ready(function(){

// Карусель
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


// Разворачивание меню
    var timeApp = 400;                          // время разворачивания меню
    var p_height = $('.app_info p').height();
    $('.buttn').toggle(function(e){
        e.preventDefault();
        $('.app_info p').animate({'height':'0'},timeApp,function(){
            $('.app_info p').css('display','none')
            $('.buttn').attr('src','images/log_vee.png')
        });
    },function(ee){
        ee.preventDefault();
        $('.app_info p').css('display','inline-block')
        $('.app_info p').animate({'height':p_height},timeApp,function(){
            $('.buttn').attr('src','images/log_wedge.png')
        });
    })


// Смена фона
    var timeInterval = 4000;        // промежуток между слайдами
    var timeFade = 2000;            // время слайда
    function bg_app(adress){
        $('.bgcontent').animate({'opacity':'1'},timeFade,function(){
            $('#content').css('background-image',adress)
        })
    }
    function bg_disapp(adress){
        $('.bgcontent').animate({'opacity':'0'},timeFade,function(){
            $('.bgcontent')
                .css('background-image',adress)
        })
    }
    var image1 = 'url(images/bg_menu1.jpg)';
    var image2 = 'url(images/bg_menu2.jpg)';
    var image3 = 'url(images/bg_menu3.jpg)';
    var image4 = 'url(images/bg_menu4.jpg)';
    var image5 = 'url(images/bg_menu5.jpg)';
    var image6 = 'url(images/bg_menu6.jpg)';
    var animfirst = function(){
        setTimeout(function(){bg_disapp(image3)},timeInterval)
        setTimeout(function(){bg_app(image4)},2*timeInterval+timeFade)
        setTimeout(function(){bg_disapp(image5)},3*timeInterval+2*timeFade)
        setTimeout(function(){bg_app(image6)},4*timeInterval+3*timeFade)
        setTimeout(function(){bg_disapp(image1)},5*timeInterval+4*timeFade)
        setTimeout(function(){bg_app(image1)},6*timeInterval+5*timeFade)
    }
    var animcycle = function(){
        setInterval(animfirst,5*timeInterval+5*timeFade)
    }
    setTimeout(animfirst,0)
    setTimeout(animcycle,0)


})