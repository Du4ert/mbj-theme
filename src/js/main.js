// ===== Scroll to Top ====
$(function() {
$('<a id="return-to-top" href="javascript:"><span class="glyphicon glyphicon-chevron-up"></span></a>').appendTo('body');
$(window).scroll(function() {
    if ($(this).scrollTop() >= 100) {        // If page is scrolled more than 50px
        $('#return-to-top').fadeIn(200);    // Fade in the arrow
    } else {
        $('#return-to-top').fadeOut(200);   // Else fade out the arrow
    }
});
$('#return-to-top').click(function() {      // When arrow is clicked
    $('body,html').animate({
        scrollTop : 0                       // Scroll to top of body
    }, 500);
});
});
// scroll to top



// How to cite plugin / copy to clipboard
$(function() {
$('#copy').click(function() {
    var element = $('#citationOutput');
    var temp = $("<input>");
    $("body").append(temp);
    var str = temp.val($.trim($(element).text())).select();
    document.execCommand("copy");
    temp.remove();
});
}); // how to cite



// Modal for galleys
$(function() {
$('.modal-resize').click(function () {
    $(this).closest('.modal-dialog').toggleClass('modal-dialog-fullscreen');
});

// Сворачивает модальное окно при закрытии
$('.modal').on('hidden.bs.modal', function () {
    $(this).find('.modal-dialog-fullscreen').removeClass('modal-dialog-fullscreen');
})


// Воспроизведение видео при открытии модального окна
$('.modal').on('shown.bs.modal', function () {
    if (this.querySelector('.modal-video')) {
        this.querySelector('.modal-video').play();
    }
})

// Пауза видео при закрытии модального окна
$('.modal').on('hide.bs.modal', function () {
    if (this.querySelector('.modal-video')) {
        this.querySelector('.modal-video').pause();
    }
})
}); // modal for galleys


// Search
$(function() {
let $search = $('.search');
let $searchInput = $('.search-input');
let $searchForm = $('.search-form');
let $searchIcon = $('.search-icon');

let clickElsewereSearch = (e) => {
    if (e.target.closest('.search')) {
        return false;
    }
    addSearchMin();
    $(document).off('click', clickElsewereSearch);
}

let removeSearchMin = () => {
    if ($search.hasClass('search-min')) {
        $search.removeClass('search-min');
        $(document).click(clickElsewereSearch);
    }
}

let addSearchMin = () => {
    if (!$search.hasClass('search-min')) {
        $search.addClass('search-min');
    };
}

$search.addClass('search-min');

$search.click(function(e) {
    $target = $(e.target);

    if ($search.hasClass('search-min')) {
        if ($target.is($searchIcon)) 
        {
            removeSearchMin();
            $searchInput.focus();
        } else if ($target.is($searchInput)) {
            removeSearchMin();
        }
    } 
    else {
        if ($target.is($searchIcon)) {
            $searchForm.trigger('submit');
        }
    }
});

// Hover (only on desktop)
if (!("ontouchstart" in document.documentElement)) {
        $search.hover(function(e) {
        removeSearchMin();
    }, function(e) {
        if (!$searchInput.is(':focus')) {
            addSearchMin();
        }
        
    });
}
});
// //search


// Header fixed
$(function() {
    let header = $('.header-custom');
    let topNavigation = $('.top-navigation');
    let headerHero = $('.header-hero');
    let headerBottom = headerHero.position().top + headerHero.height();
    console.log(headerBottom);

    $(document).scroll(function(e) {
        let scrollTop = $(window).scrollTop();

        
        if (scrollTop >= headerBottom) {
            header.addClass('fixed');
        }
        else if (header.hasClass('fixed')) {
            header.removeClass('fixed');
        }
    });
    
});

// Sidebar
$(function() {
let $sidebar = $('#sidebar');
let $sidebarTrigger = $sidebar.find('.sidebar-trigger');
let $sidebarTriggerIcon = $sidebarTrigger.find('.glyphicon');
let $header = $('#headerNavigationContainer');
let animation = false;
let sidebarTriggerSizeChange = () => {
    let headerHeight = $header.height();
    let scrollTop = $(window).scrollTop();

    if (scrollTop >= headerHeight) {
        $sidebarTrigger.css('top', '0');
    } else {
        $sidebarTrigger.css('top', headerHeight - scrollTop );
    }
    if (animation) {
        window.requestAnimationFrame(sidebarTriggerSizeChange);
    }
};
let sidebarAnimate = () => {
    animation = true;
    sidebarTriggerSizeChange();
};
let sidebarToggle = () => {
    if (!$sidebar.hasClass('sidebar-min_open')) {
        $sidebar.addClass('sidebar-min_open');
        $sidebarTriggerIcon.removeClass('glyphicon-chevron-left');
        $sidebarTriggerIcon.addClass('glyphicon-chevron-right');
       } else {
        $sidebar.removeClass('sidebar-min_open');
        $sidebarTriggerIcon.addClass('glyphicon-chevron-left');
        $sidebarTriggerIcon.removeClass('glyphicon-chevron-right');
       }
};


$("#sidebar").swipe( {
    swipeLeft: function(e) {
        if (e.target.closest('.sidebar-trigger')) {
            sidebarToggle();
        }
    },
    swipeRight: function(e) {
        if (e.target.closest('.sidebar-min') && $sidebar.hasClass('sidebar-min_open')) {
            sidebarToggle();
        }
    }
});

$sidebarTrigger.click(sidebarToggle);
$('#nav-menu').on('show.bs.collapse', sidebarAnimate);
$('#nav-menu').on('shown.bs.collapse', () => animation = false);
$('#nav-menu').on('hide.bs.collapse', sidebarAnimate);
$('#nav-menu').on('hidden.bs.collapse', () => animation = false);
$(document).scroll(sidebarTriggerSizeChange);

$sidebar.addClass('sidebar-min');
sidebarTriggerSizeChange();
});
// /sidebar

// Language change
function changeLanguage() {
    var e = document.getElementById('languageSelect');
    var new_locale = e.options[e.selectedIndex].value;

    var redirect_url = '{url|escape:"javascript" page="user" op="setLocale" path="NEW_LOCALE" source=$smarty.server.REQUEST_URI escape=false}';
    redirect_url = redirect_url.replace("NEW_LOCALE", new_locale);

    window.location.href = redirect_url;
} // /language change
