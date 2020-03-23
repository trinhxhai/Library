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
    public class LibraryDbInitzer : DropCreateDatabaseIfModelChanges<LibraryContext>
    {
        private static int lastBorBookId =0;
        protected override void Seed(LibraryContext context)
        {
            TemplateUser().ForEach(user => context.Users.Add(user));
            TemplateBook().ForEach(book =>context.Books.Add(book));

            context.SaveChanges();

            List<Book> listBook = TemplateBook();

            for (int i = 0; i < listBook.Count; i++)
            {
                for (int j = 0; j < Int16.Parse(listBook[i].amount); j++)
                {
                    int bookId = listBook[i].bookId;
                    context.BorBooks.Add(
                                new BorBook
                                {
                                    id = ++lastBorBookId,
                                    BookId = context.Books.FirstOrDefault(book => book.bookId == bookId).bookId,
                                    returnDate = DateTime.Now,
                                    state = false
                                }
                        ); ;
                }
            }
            context.SaveChanges();

        }
        private static List<User> TemplateUser()
        {
            var listUser = new List<User> {
                new User
                {
                    userName="Hai",
                    passWord="123456",
                    role="admin"
                },
                new User
                {
                    userName="Toan",
                    passWord="123456",
                    role="admin"
                },
                new User
                {
                    userName="Linh",
                    passWord="123456",
                    role="admin"
                },
                new User
                {
                    userName="Trung",
                    passWord="123456",
                    role="user"
                },
                new User
                {
                    userName="Tuan",
                    passWord="123456",
                    role="user"

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



             };
            
            return tmp;
        }


    }
}