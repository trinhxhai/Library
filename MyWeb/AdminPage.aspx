﻿
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="MyWeb.ListUser"  %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="~/Style/Layout.css" rel="stylesheet" type="text/css" media="screen" runat="server" />
    <link href="~/Style/AdminPage.css" rel="stylesheet" type="text/css" media="screen" runat="server" />
    
</head>
<body>
    <form id="form1" runat="server">

        <div class="navBar">
            <a href="ListBook.aspx" class="logoLink">
                <img src="Images/Logo.jpg" />
            </a>
            <ul class="navMenu">
                <li><a href="ListBook.aspx">Trang Chủ</a></li>
                <li><a href="AdminPage.aspx">Admin</a></li>
                <li><a href="Location.aspx"> Địa điểm </a></li>
                <li><a href="Introduction.aspx">Giới thiệu </a></li>
            </ul>
            <div id="headerLoginBox" runat="server">
                <a href="Login.aspx">Đăng nhập</a>
            </div>
            <div id="userNav"  runat="server">
                <a href="UserDetails.aspx?username=<%:username%>">Hello <%:username%></a>
                <asp:Button ID="logoutBtn" runat="server" Text="Logout" OnClick="logoutBtn_Click" />
            </div>
        </div>
        
        <div id="viewContainer">
        <div id="menuBar">   
            <asp:Button ID="viewListUser" runat="server" Text="Users"  OnClick="viewListUser_Click" />
            <asp:Button ID="viewAddUser" runat="server" Text="Add User" OnClick="viewAddUser_Click" />
            <asp:Button ID="viewNewBook" runat="server" Text="Add Book" OnClick="viewNewBook_Click" />
            <asp:Button ID="viewBorBook" runat="server" Text="Borrow Book" OnClick="viewBorBook_Click" />
        </div>

        <!-- Bên trái-->
        <asp:MultiView ID="inforMView" runat="server" ActiveViewIndex="0">
            <asp:View ID="UserView" runat="server">
                <div id ="listUserView">
                <asp:Label ID="locationInfo" runat="server" Text="Địa điểm : "></asp:Label>
                <input type="text" id="inpFilter" onkeyup="filterUser()" placeholder="Tìm kiếm"/>

                <asp:ListBox ID="listBoxUser" runat="server" OnSelectedIndexChanged="listBoxUser_SelectedIndexChanged" AutoPostBack="True">
                </asp:ListBox>

                <asp:Button ID="removeUserBtn" runat="server" Text="Xóa User" OnClick="removeUserBtn_Click" />
                <asp:BulletedList ID="listUserMessages" runat="server"></asp:BulletedList>
                </div>
            </asp:View>
            <asp:View ID="addUserView" runat="server">
                <div id="addUser"  class="info" >
                    <h2> Thêm user</h2>

                    <table>
                        <tr>
                            <td>
                                <label>User name:</label>
                            </td>
                            <td>
                                <asp:TextBox ID="inpUserName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Password:</label>
                            </td>
                            <td>
                                <asp:TextBox ID="inpPassWord" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>CMND:</label>
                            </td>
                            <td>
                                <asp:TextBox ID="inpCMND" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Real name:</label>
                            </td>
                            <td>
                                <asp:TextBox ID="inpRealName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Dia chi:</label>
                            </td>
                            <td>
                                <asp:TextBox ID="inpDchi" runat="server"></asp:TextBox>
                            </td>
                        </tr><tr>
                            <td>
                                <label>Role:</label>
                            </td>
                            <td>
                                <asp:DropDownList ID="inpRole" runat="server">
                                    <asp:ListItem Value="user">User</asp:ListItem>  
                                    <asp:ListItem Value="admin">Admin</asp:ListItem>  
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="addUserBnt" runat="server" Text="Add User" onclick="addUserBnt_Click" />

                            </td>
                        </tr>
                        
                    </table>

                    <asp:BulletedList ID="validUserErrors" runat="server">
                    </asp:BulletedList>
                </div>
            </asp:View>
            <asp:View ID="newBookView" runat="server">
                
                <div id="newBook"  class="info" >
                    <h2>Thêm sách</h2>

                    <table> 
                        <tr>
                            <td><label>Tên Sách</label></td>
                            <td><asp:TextBox ID="BookName" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><label>Loại sách :</label></td>
                            <td><asp:TextBox ID="BookCategory" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><label>Giới thiệu :</label></td>
                            <td><asp:TextBox ID="BookDescription" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><label>Giá bán :</label></td>
                            <td><asp:TextBox ID="BookPrice" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><label>Số Lượng :</label></td>
                            <td><asp:TextBox ID="Amount" runat="server"></asp:TextBox></td>
                        </tr>
                    </table>
                    <asp:FileUpload ID="ImageUpload" runat="server" />
                    <asp:Button ID="addBookBnt" runat="server" Text="Add Books" onclick="addBookBnt_Click"/>
                    <asp:BulletedList ID="validBookErrors" runat="server">
                    </asp:BulletedList>
                </div>
                
            </asp:View>
            <asp:View ID="borBookView" runat="server">
                <div id="borrowBook"  class="info" >
                    <asp:Label ID="borrowBook_locationInfo" runat="server" Text="Địa điểm : "></asp:Label>
                    <h2>Mượn sách</h2>
                    <input type="text" onkeyup="borView_userFilter()" id="borViewUserFilter" placeholder="Lọc người dùng"/>
                    <input type="text" onkeyup="borView_bookFilter()" id="borViewBookFilter" placeholder="Lọc sách"/>
                    <br />
                    <asp:ListBox ID="listBorUser" runat="server" OnSelectedIndexChanged="listBorUser_SelectedIndexChanged" AutoPostBack="True">
                    </asp:ListBox>
                    <asp:ListBox ID="listBorBook" runat="server" AutoPostBack="True" OnSelectedIndexChanged="listBorBook_SelectedIndexChanged">
                    </asp:ListBox>
                    <br />
                    <label>Thời hạn</label>

                    <asp:DropDownList ID="returnDate" runat="server" >
                        <asp:ListItem Value="1">1 Tuần</asp:ListItem>  
                        <asp:ListItem Value="2">2 Tuần</asp:ListItem>  
                        <asp:ListItem Value="3">3 Tuần</asp:ListItem>  
                        <asp:ListItem Value="4">4 Tuần</asp:ListItem>  
                    </asp:DropDownList>

                    <asp:Button ID="borrowBtn" runat="server" Text="Borrow" OnClick="borrowBtn_Click" />

                    <asp:BulletedList ID="borrowMessages" runat="server" ViewStateMode="Disabled"></asp:BulletedList>
                </div>
            </asp:View>
            
        </asp:MultiView>

        <!-- Bên phải-->
        <asp:MultiView ID="preMView" runat="server" ActiveViewIndex="0">
            <asp:View ID="View5" runat="server">
                <div id="previewUser"> 
                    <div id="preUserInfo">
                        <table>
                            <tr id="seditBtn">
                                <td>
                                    <asp:Button ID="editUser" runat="server" Text="Edit" OnClick="editUser_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="saveUser" runat="server" Text="Save" OnClick="saveUser_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:BulletedList ID="validationUserError" runat="server" EnableViewState="False"></asp:BulletedList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Username :</label>
                                </td>
                                <td>
                                    <asp:Label ID="accName" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Password :</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="passWord" runat="server" Enabled="False" ViewStateMode="Enabled"  ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Họ tên :</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="realName" runat="server" Enabled="False" ViewStateMode="Enabled"  ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>CMND :</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="CMND" runat="server" Enabled="False" ViewStateMode="Enabled"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Địa chỉ :</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="dchi" runat="server" Enabled="False" ViewStateMode="Enabled"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>Số lượng sách đang mượn :</label>
                                </td>
                                <td>
                                    <asp:Label ID="borBookCount" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                    
                    <div id="previewUserBook">
                        <asp:ListBox ID="userListBorBook" runat="server" AutoPostBack="True" OnSelectedIndexChanged="userListBorBook_SelectedIndexChanged" >
                        </asp:ListBox>
                        <asp:Button ID="returnBookBtn" runat="server" Text="Trả sách" OnClick="returnBookBtn_Click" Enabled="False" />
                        <asp:Image ID="previewUserBookPic" runat="server" />
                    </div>
                    
                </div>

            </asp:View>
            <asp:View ID="previewBook" runat="server">
                <div id="previewBook" class="preview">
                    <h2>Preview Book</h2>
                    <div id="inforPreviewBook">
                        <label>Tên Sách : </label> 
                            <asp:Label ID="previewNameBook" runat="server" Text=""></asp:Label>
                        <br />
                        <label>Loại sách :</label>
                            <asp:Label ID="previewCategoryBook" runat="server" Text=""></asp:Label>
                        <br />
                        <label>Giới thiệu :</label>
                        <asp:Label ID="previewDecriptionBook" runat="server" Text=""></asp:Label>
                        <br />
                        <label>Giá bán :</label> 
                        <asp:Label ID="previewPriceBook" runat="server" Text=""></asp:Label>
                    </div>

                    <asp:Image ID="previewPicBook" runat="server" class="bookPic"/>

                    <asp:BulletedList ID="borBookMessage" runat="server" >
                    </asp:BulletedList>
                </div>
            </asp:View>
            
            <asp:View runat="server">
                <div id="addBorBook">
                    <asp:Label ID="addBook_locationInfo" runat="server" Text="Địa điểm : "></asp:Label>
                    <label>Tìm sách</label>
                    <input type="text" onkeyup="addBookView_bookFilter()" id="addBookViewBookFilter" placeholder="Lọc sách"/>
                    <br />
                    <asp:ListBox ID="addBorBookList" runat="server" OnSelectedIndexChanged="addBorBookList_SelectedIndexChanged" AutoPostBack="True"></asp:ListBox>
                    <br />
                    <h2>Thêm BorBook</h2>
                    <label>Số lượng : </label>
                    <asp:TextBox ID="addingAmount" runat="server" EnableViewState="False"></asp:TextBox>
                    <asp:Button ID="addMoreBorBook"  runat="server" Text="Thêm" OnClick="addMoreBorBook_Click"  />
                    <br />
                    <asp:BulletedList ID="addBorBookMessage" runat="server"></asp:BulletedList>

                    <asp:Table ID="removeBorBookTable" runat="server"></asp:Table>
                    
                </div>
            </asp:View>
        
        </asp:MultiView>

        </div>


    </form>
    <footer>1412</footer>
    <script>
        var borBox = document.getElementById("listBorBook");
        var listBook = borBox.getElementsByTagName("option");
        for (var i = 0; i < listBook.length; i++) {
            var idx = listBook[i].innerHTML.indexOf("[ Đã đặt trước ]");
            if (idx != -1) {
                listBook[i].innerHTML = listBook[i].innerHTML.substr(0, listBook[i].innerHTML.indexOf("[")) +"&nbsp";
                listBook[i].classList.add("orderFlag");
            }
            // 
            
            idx = listBook[i].innerHTML.indexOf("[ Đã mượn ]");
            if (idx != -1) {
                listBook[i].innerHTML = listBook[i].innerHTML.substr(0, listBook[i].innerHTML.indexOf("[")) + "&nbsp";
                listBook[i].classList.add("borrowedFlag");
            }
            idx = listBook[i].innerHTML.indexOf("[Đã hết]");
            if (idx != -1) {
                listBook[i].innerHTML = listBook[i].innerHTML.substr(0, listBook[i].innerHTML.indexOf("[")) + "&nbsp";
                listBook[i].classList.add("allOutFlag");
            }

        }

    </script>
</body>

</html>
