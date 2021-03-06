﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
namespace MyWeb.Models
{
    // DropCreateDatabaseAlways nếu muốn db được tạo mới mỗi lần chạy
    // DropCreateDatabaseIfModelChanges chỉ khởi tạo lại db khi có nhưng thay đổi của models
    //CreateDatabaseIfNotExists
    public class LibraryDbInitzer : DropCreateDatabaseAlways<LibraryContext>
    {

        private static int lastBorBookId =0;
        protected override void Seed(LibraryContext context)
        {
            // trong User có ref đến Location nên cần thêm và lưu trước !
            List<Location> listLocation = TemplateLocation();
            listLocation.ForEach(loc => context.Locations.Add(loc));
            context.SaveChanges();

            TemplateUser().ForEach(user => context.Users.Add(user));

            List<Book> listBook = TemplateBook();
            listBook.ForEach(book => context.Books.Add(book));
            context.SaveChanges();

            for (int i = 0; i < listBook.Count; i++)
            {
                for (int j = 0; j < Int16.Parse(listBook[i].amount); j++)
                {
                    int bookId = listBook[i].bookId;
                    Book book = context.Books.FirstOrDefault(b => b.bookId == bookId);
                    context.BorBooks.Add(
                                new BorBook
                                {
                                    id = ++lastBorBookId,
                                    BookId = book.bookId,
                                    borrowDate = DateTime.Now,
                                    returnDate = DateTime.Now,
                                    state = 0,
                                    // rải đều cho 4 location mặc định
                                    LocationId = j % 4 + 1
                                }
                        ); ; 
                }
            }

            genRandomBook(ref context, 80);
            context.SaveChanges();

        }

        private static List<Location> TemplateLocation()
        {
            var listLocation = new List<Location> { 
                new Location
                {
                    id = 1,
                    dchi="Nhà sách Phương Nam, Giáp Bát, Hà Nội"
                },
                new Location
                {
                    id = 2,
                    dchi = "Thư viện An Nam, Cầu giấy, Hà Nội"
                },
                new Location
                {
                    id = 3,
                    dchi = "Nhà sách Đông Lào, Long Biên, Hà Nội"
                },
                new Location
                {
                    id = 4,
                    dchi = "Thư Viện VinBook, Hoàn Kiếm, Hà Nội"
                },

             };
            return listLocation;
        }
        private static List<User> TemplateUser()
        {
            var listUser = new List<User> {
                new User
                {
                    userName="Hai",
                    passWord="123456",
                    realName="trinh xuan hai",
                    CMND="012345678912",
                    role="admin",
                    LocationId=1
                },
                new User
                {
                    userName="Toan",
                    passWord="123456",
                    realName="bui van toan",
                    CMND="012345678912",
                    role="admin",
                    LocationId=1
                },
                new User
                {
                    userName="nam",
                    passWord="123456",
                    realName="tran hai nam",
                    CMND="012345678912",
                    role="admin",
                    LocationId=2
                },
                new User
                {
                    userName="Trung",
                    passWord="123456",
                    realName="Nguyễn Trung Trực",
                    CMND="012345678912",
                    role="admin",
                    LocationId=3
                },
                new User
                {
                    userName="Tuan",
                    passWord="123456",
                    realName="TUAN ahihi",
                    CMND="012345678912",
                    role="user",
                    LocationId=3
                }
            };
            return listUser;
        }
        
        private static List<Book> TemplateBook()
        {
            List<Book> tmp = new List<Book>()
            {
                new Book()
                {
                       bookId = 1,
                       bookName ="Cà phê sáng cùng Tony",
                       category ="Self help",
                       price="65000",
                       imagePath ="CaPheSangCungTony.jpg",
                       amount="1"
                },
                new Book()
                {
                       bookId = 2,
                       bookName ="Competitive Programmer's Handbook",
                       category ="Programming",
                       price="240000",
                       imagePath ="Competitive Programmer's Handbook-Antti Laaksonen.jpg",
                       amount="10"
                },
                new Book()
                {
                       bookId = 3,
                       bookName ="Lão Hạc",
                       category ="Văn học",
                       price="240000",
                       imagePath ="LaoHac.jpg",
                       amount="13"
                },
                new Book()
                {
                       bookId = 4,
                       bookName ="Competitive Programming 3",
                       category ="Programming",
                       price="240000",
                       imagePath ="Competitive Programming 3.jpg",
                       amount="13"
                },
                new Book()
                {
                       bookId = 5,
                       bookName ="I Don't Know JS",
                       category ="Programming",
                       price="220000",
                       imagePath ="JDK_JS.jpg",
                       amount="11"
                },
                new Book()
                {
                       bookId = 6,
                       bookName ="Thế giới phẳng",
                       category ="Văn học;Self Help",
                       price="240000",
                       imagePath ="TGPhang.jpg",
                       amount="13"
                },
                new Book()
                {
                       bookId = 6,
                       bookName ="Lão và tôi",
                       category ="Văn học",
                       price="140000",
                       imagePath ="LaoSomeThing.png",
                       amount="13"
                },




             };
            
            return tmp;
        }


        public string genRandomString(ref Random rand, int len)
        {
            string res = "";
            for (int i = 0; i < len; i++) res += (char)(rand.Next(97, 122));
            return res;
        }
        public void genRandomBook(ref LibraryContext db,int num)
        {
            int fId = db.Books.Max(b => b.bookId) + 1;
            Random rand = new Random();
            for (int i = 0; i < num; i++)
            {
                Book tmp = new Book
                {
                    bookId = fId++, // Id của sách sẽ +1 so với id  lớn nhất của các sách hiện tại
                    bookName = genRandomString(ref rand, 8),
                    category = genRandomString(ref rand, 5),
                    amount = "10",
                    imagePath = "LaoSomeThing.png",
                    price = "150000",
                };
                db.Books.Add(tmp);
                db.SaveChanges();
                // Sinh các borrowable cho book
                Book.genBorBook(tmp);
                db.SaveChanges();
            }
        }

    }
}