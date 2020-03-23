﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListBook.aspx.cs" Inherits="MyWeb.ListBook" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="">
    <link href="~/Style/Books.css" rel="stylesheet" type="text/css" media="screen" runat="server" /> 
    <link href="~/Style/Layout.css" rel="stylesheet" type="text/css" media="screen" runat="server" />
    <link href="~/Style/ListBook.css" rel="stylesheet" type="text/css" media="screen" runat="server" />
    <script src="Script/BookFilter.js"></script>
    <style>


        
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="searchBtn">
        
        <div class="navBar">
            <a href="ListBook.aspx" class="logoLink">
                <img src="Images/Logo.jpg" />
            </a>
            <ul class="navMenu">
                <li><a href="AdminPage.aspx">Admin</a></li>
                <li><a href=""> Trả sách </a></li>
                <li><a href="Login.aspx">Đăng nhập</a></li>
                <li><a href="">Đăng kí </a></li>
            </ul>
        </div>


        <div id="bodyDiv">
            <div id="searchBar">
                <asp:TextBox ID="searchTextBox" runat="server" ></asp:TextBox>
                <asp:Button ID="searchBtn" runat="server" Text="Tìm kiếm" OnClick="searchBtn_Click" />
            </div>
            <div id="categoryArea">
                <label id="titleCategory">
                    Thể Loại
                </label>
                <asp:Button ID="removeCheck" runat="server" Text="Bỏ chọn" OnClick="removeCheck_Click" />
                <asp:CheckBoxList ID="categoryCheckList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="categoryCheckList_SelectedIndexChanged"></asp:CheckBoxList>
            </div>
            <div id="bookContainer">
                <%for( int i=0 ; i < curListBook.Count ; i++ ) %>
                <%{ %>
                <div class="book">
                    <div class="bookPic">
                        <a href="BookDetails.aspx?bookId=<%:curListBook[i].bookId.ToString()%>">
                            <image src="Images/<%:curListBook[i].imagePath%>"></image>
                        </a>
                    </div>
                    <div class="bookInfo">
                        <h3 class="bookTitle">
                            <a href="BookDetails.aspx?bookId=<%:curListBook[i].bookId.ToString()%>"> <%:curListBook[i].bookName %></a>
                        </h3>
                    </div>
                <a href="EditBook.aspx?bookId=<%:curListBook[i].bookId.ToString()%>" style="display: <%:adminMode%>; " class="editLink">
                    Sửa
                </a>
                <a href="RemoveBook.aspx?bookId=<%:curListBook[i].bookId.ToString()%>" style="display: <%:adminMode%>; " class="removeLink">
                    Xóa
                </a>
                </div>
            
                <%} %>
            </div>
            <div id="pageNav">
                <asp:Button ID="prevPageBtn" runat="server" Text="Trang trước" OnClick="prevPageBtn_Click" />
                <asp:TextBox ID="inpPage" runat="server" Enabled="False"></asp:TextBox>
                <asp:Button ID="nextPageBtn" runat="server" Text="Trang tiếp" OnClick="nextPageBtn_Click" />

            </div>
        </div>
    </form>
<footer>1a412</footer>
</body>
</html>