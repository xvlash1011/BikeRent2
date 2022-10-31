<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="main.ascx.cs" Inherits="ShopsDefault.AdminTools.Modules.Header.main" %>

<script>
    $(function () {
        $('.avatar .has-sub').click(function () {

            $('.hd-nav-sub').toggle();
        });
    });
</script>

<div class="hd-menu">
    <div class="row">
        <div class="col-6">
            <div class="hd-item">
                <div class="hd-logo">
                    <a href="#">
                        <img src="/AdminTools/images/logo-cho-thue-xe-may-QM-white.png" height="40" /></a>
                </div>
                <div class="hd-toggler-icon">
                    <i class="icon-menu"></i>
                </div>
                <div class="hd-nav">
                    <ul>
                        <li><a href="/AdminTools/Dashboard.html">Dashboard</a></li>
                        <li><a href="#">Account</a></li>
                        <li><a href="#">Settings</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-6">
            <div class="hd-item">
                <div class="hd-user-setting hd-nav">
                    <ul>
                        <li class="avatar">
                            <a class="has-sub" href="#">
                                <img src="/AdminTools/images/user/minh-quoc.jpg" /></a>
                            <ul class="hd-nav-sub">
                                <li class="nav-group">Settings</li>
                                <li>
                                    <a href="#"><i class="icon-settings"></i>Change Password</a>
                                </li>
                                <li>
                                    <a href="/AdminTools/Login.html"><i class="icon-logout"></i>Log out</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
