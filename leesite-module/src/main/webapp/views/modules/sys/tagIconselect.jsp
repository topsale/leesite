<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/include/taglib.jsp" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="zh" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>图标选择</title>
    <meta name="decorator" content="blank"/>

    <style type="text/css">
        .page-header {
            clear: both;
            margin: 0 20px;
            padding-top: 20px;
        }

        .the-icons {
            padding: 25px 10px 15px;
            list-style: none;
        }

        .the-icons li {
            float: left;
            width: 33%;
            height: 40px;
            padding-top: 12px;
            cursor: pointer;
        }

        .the-icons i {
            margin: 1px 5px;
            font-size: 16px;
        }

        .the-icons li:hover {
            background-color: #efefef;
        }

        .the-icons li.active {
            background-color: #0088CC;
            color: #ffffff;
        }

        .the-icons li:hover i {
            font-size: 20px;
        }
    </style>
</head>

<body style="background: white;">
<input type="hidden" id="icon" value="${value}"/>
<div id="icons">
    <h4 class="page-header">Simple Line Icons. 162 Beautifully Crafted WebFont Icons.</h4>
    <ul class="the-icons">
        <li class="col-md-3 col-sm-4"><i class="icon-user"></i> icon-user</li>
        <li class="col-md-3 col-sm-4"><i class="icon-user-female"></i> icon-user-female</li>
        <li class="col-md-3 col-sm-4"><i class="icon-users"></i> icon-users</li>
        <li class="col-md-3 col-sm-4"><i class="icon-user-follow"></i> icon-user-follow</li>
        <li class="col-md-3 col-sm-4"><i class="icon-user-following"></i> icon-user-following</li>
        <li class="col-md-3 col-sm-4"><i class="icon-user-unfollow"></i> icon-user-unfollow</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-trophy"></i> icon-trophy</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-speedometer"></i> icon-speedometer</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-social-youtube"></i> icon-social-youtube</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-social-twitter"></i> icon-social-twitter</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-social-tumblr"></i> icon-social-tumblr</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-social-facebook"></i> icon-social-facebook</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-social-dropbox"></i> icon-social-dropbox</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-social-dribbble"></i> icon-social-dribbble</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-shield"></i> icon-shield</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-screen-tablet"></i> icon-screen-tablet</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-screen-smartphone"></i> icon-screen-smartphone</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-screen-desktop"></i> icon-screen-desktop</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-plane"></i> icon-plane</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-notebook"></i> icon-notebook</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-moustache"></i> icon-moustache</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-mouse"></i> icon-mouse</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-magnet"></i> icon-magnet</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-magic-wand"></i> icon-magic-wand</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-hourglass"></i> icon-hourglass</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-graduation"></i> icon-graduation</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-ghost"></i> icon-ghost</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-game-controller"></i> icon-game-controller</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-fire"></i> icon-fire</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-eyeglasses"></i> icon-eyeglasses</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-envelope-open"></i> icon-envelope-open</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-envelope-letter"></i> icon-envelope-letter</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-energy"></i> icon-energy</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-emoticon-smile"></i> icon-emoticon-smile</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-disc"></i> icon-disc</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-cursor-move"></i> icon-cursor-move</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-crop"></i> icon-crop</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-credit-card"></i> icon-credit-card</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-chemistry"></i> icon-chemistry</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-bell"></i> icon-bell</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-badge"></i> icon-badge</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-anchor"></i> icon-anchor</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-action-redo"></i> icon-action-redo</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-action-undo"></i> icon-action-undo</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-bag"></i> icon-bag</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-basket"></i> icon-basket</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-basket-loaded"></i> icon-basket-loaded</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-book-open"></i> icon-book-open</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-briefcase"></i> icon-briefcase</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-bubbles"></i> icon-bubbles</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-calculator"></i> icon-calculator</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-call-end"></i> icon-call-end</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-call-in"></i> icon-call-in</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-call-out"></i> icon-call-out</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-compass"></i> icon-compass</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-cup"></i> icon-cup</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-diamond"></i> icon-diamond</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-direction"></i> icon-direction</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-directions"></i> icon-directions</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-docs"></i> icon-docs</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-drawer"></i> icon-drawer</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-drop"></i> icon-drop</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-earphones"></i> icon-earphones</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-earphones-alt"></i> icon-earphones-alt</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-feed"></i> icon-feed</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-film"></i> icon-film</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-folder-alt"></i> icon-folder-alt</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-frame"></i> icon-frame</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-globe"></i> icon-globe</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-globe-alt"></i> icon-globe-alt</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-handbag"></i> icon-handbag</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-layers"></i> icon-layers</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-map"></i> icon-map</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-picture"></i> icon-picture</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-pin"></i> icon-pin</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-playlist"></i> icon-playlist</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-present"></i> icon-present</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-printer"></i> icon-printer</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-puzzle"></i> icon-puzzle</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-speech"></i> icon-speech</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-vector"></i> icon-vector</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-wallet"></i> icon-wallet</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-arrow-down"></i> icon-arrow-down</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-arrow-left"></i> icon-arrow-left</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-arrow-right"></i> icon-arrow-right</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-arrow-up"></i> icon-arrow-up</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-bar-chart"></i> icon-bar-chart</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-bulb"></i> icon-bulb</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-calendar"></i> icon-calendar</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-control-end"></i> icon-control-end</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-control-forward"></i> icon-control-forward</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-control-pause"></i> icon-control-pause</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-control-play"></i> icon-control-play</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-control-rewind"></i> icon-control-rewind</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-control-start"></i> icon-control-start</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-cursor"></i> icon-cursor</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-dislike"></i> icon-dislike</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-equalizer"></i> icon-equalizer</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-graph"></i> icon-graph</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-grid"></i> icon-grid</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-home"></i> icon-home</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-like"></i> icon-like</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-list"></i> icon-list</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-login"></i> icon-login</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-logout"></i> icon-logout</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-loop"></i> icon-loop</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-microphone"></i> icon-microphone</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-music-tone"></i> icon-music-tone</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-music-tone-alt"></i> icon-music-tone-alt</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-note"></i> icon-note</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-pencil"></i> icon-pencil</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-pie-chart"></i> icon-pie-chart</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-question"></i> icon-question</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-rocket"></i> icon-rocket</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-share"></i> icon-share</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-share-alt"></i> icon-share-alt</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-shuffle"></i> icon-shuffle</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-size-actual"></i> icon-size-actual</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-size-fullscreen"></i> icon-size-fullscreen</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-support"></i> icon-support</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-tag"></i> icon-tag</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-trash"></i> icon-trash</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-umbrella"></i> icon-umbrella</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-wrench"></i> icon-wrench</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-ban"></i> icon-ban</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-bubble"></i> icon-bubble</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-camcorder"></i> icon-camcorder</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-camera"></i> icon-camera</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-check"></i> icon-check</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-clock"></i> icon-clock</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-close"></i> icon-close</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-cloud-download"></i> icon-cloud-download</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-cloud-upload"></i> icon-cloud-upload</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-doc"></i> icon-doc</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-envelope"></i> icon-envelope</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-eye"></i> icon-eye</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-flag"></i> icon-flag</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-folder"></i> icon-folder</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-heart"></i> icon-heart</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-info"></i> icon-info</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-key"></i> icon-key</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-link"></i> icon-link</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-lock"></i> icon-lock</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-lock-open"></i> icon-lock-open</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-magnifier"></i> icon-magnifier</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-magnifier-add"></i> icon-magnifier-add</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-magnifier-remove"></i> icon-magnifier-remove</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-paper-clip"></i> icon-paper-clip</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-paper-plane"></i> icon-paper-plane</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-plus"></i> icon-plus</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-pointer"></i> icon-pointer</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-power"></i> icon-power</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-refresh"></i> icon-refresh</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-reload"></i> icon-reload</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-settings"></i> icon-settings</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-star"></i> icon-star</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-symbol-female"></i> icon-symbol-female</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-symbol-male"></i> icon-symbol-male</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-target"></i> icon-target</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-volume-1"></i> icon-volume-1</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-volume-2"></i> icon-volume-2</li>
        <li class="fa-hover col-md-3 col-sm-4"><i class="icon-volume-off"></i> icon-volume-off</li>
    </ul>
</div>

<%@include file="/views/include/foot.jsp" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#icons li").click(function () {
            $("#icons li").removeClass("active");
            $("#icons li i").removeClass("icon-white");
            $(this).addClass("active");
            $(this).children("i").addClass("icon-white");
            $("#icon").val($(this).find('i').attr('class').split(" ")[0]);
        });

        $("#icons li").each(function () {
            if ($(this).text() == "${value}") {
                $(this).click();
            }
        });

        $("#icons li").dblclick(function(){
            top.$.jBox.getBox().find("button[value='ok']").trigger("click");
        });
    });
</script>
</body>