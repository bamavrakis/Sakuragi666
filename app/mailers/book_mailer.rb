class BookMailer < ApplicationMailer
  default from: "sakuragiebooks@gmail.com"

  # Receives the mail of the user we want to send the book to, and sends the email with the attached file.
  def send_small_book(email,user,book,message)
    @book = book
    @user = user
    @message = message
    attachments[File.basename(@book.document.path)] = File.read(@book.document.path)
    mail(to: email, subject: 'You just received a book!')
  end

  # Receives the mail of the user we want to send the book to, and sends the email with the link to download it.
  def send_big_book(email,user,book,message)
    @book = book
    @user = user
    @message = message
    mail(to: email, subject: 'You just received a book!')
  end

end
