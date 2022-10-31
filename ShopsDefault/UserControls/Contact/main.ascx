<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="main.ascx.cs" Inherits="ShopsDefault.UserControls.Contact.main" %>
<style>
    .btn-default {
        margin-bottom: 0;
        margin-top: 0;
    }

    .card-body .form-group label {
        font-weight: 500;
    }

    .block-header.custome-block-header {
        padding-top: 20px;
        margin-bottom: 20px;
        font-size: 25px;
    }

        .block-header.custome-block-header:before {
            bottom: -13px;
        }

        .block-header.custome-block-header:after {
            bottom: -10px;
        }
</style>
<script>
    $(function () {
        $('.btn-contact').click(function (e) {
            if ($('.check-contact-name').val() == '') {
                alert('Subject title');
                $('.check-contact-name').focus();
                e.preventDefault();
            } else if ($('.check-full-name').val() == '') {
                alert('Your name');
                $('.check-full-name').focus();
                e.preventDefault();
            } else if ($('.check-phone').val() == '') {
                alert('Your phone number');
                $('.check-phone').focus();
                e.preventDefault();
            } else if ($('.check-email').val() == '') {
                alert('Your email');
                $('.check-email').focus();
                e.preventDefault();
            } else if ($('.check-detail').val() == '') {
                alert('Your message');
                $('.check-detail').focus();
                e.preventDefault();
            }
        });
    });
</script>
<div class="contact-default">
    <div class="container">
        <div class="row">
            <div class="col-6">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.137840514864!2d106.65107171476419!3d10.800753192305008!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317529477b5c7c99%3A0x567b889fd80bf3d8!2zMjAgxJAuIEPhu5luZyBIw7JhLCBQaMaw4budbmcgNCwgVMOibiBCw6xuaCwgVGjDoG5oIHBo4buRIEjhu5MgQ2jDrSBNaW5oLCBWaWV0bmFt!5e0!3m2!1sen!2s!4v1666937523344!5m2!1sen!2s" width="100%" height="570" frameborder="0" style="border: 0;" allowfullscreen=""></iframe>
            </div>
            <div class="col-6">
                <div class="block-header custome-block-header">Contact Us</div>
                <%--<div>
                   <p>Our contact details:</p>
                        <p>Hotline: <a href="tel:02873002266" style="font-size: 19px; font-weight: 500;">028.7300.2266</a></p>
                        <p><i class="fa fa-map-marker"></i><b>Address</b>: 20 Cong Hoa, Ward 12, Tan Binh, HCMC</p>
                        <p><i class="fa fa-envelope"></i><b>Email</b>: <a href="mailto:dnvknguyen@gmail.com">dnvknguyen@gmail.com</a></p>
                    
                </div>--%>
                <div>
                    <div class="form-group">
                        <label for="company">Subject</label>
                        <asp:TextBox ID="txtContactName" runat="server" placeholder="Subject" CssClass="form-control check-contact-name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="company">Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" placeholder="Name" CssClass="form-control check-full-name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="company">Phone number</label>
                        <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone number" CssClass="form-control check-phone"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="company">Email address</label>
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email address" CssClass="form-control check-email"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="street">Message</label>
                        <asp:TextBox ID="txtDetail" runat="server" TextMode="MultiLine" placeholder="Message" CssClass="form-control check-detail"></asp:TextBox>
                    </div>
                    <div class="form-actions text-center">
                        <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click" CssClass="btn-default btn-contact" Text="Submit"></asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

