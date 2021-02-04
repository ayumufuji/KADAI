class BooksController < ApplicationController
  def new
    @book = Book.new
    
  end
  def create
    # １. データを新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
  if @book.save
    
    flash[:notice] = "successfully!"
    redirect_to book_path(@book.id)
    
  else 
    @books = Book.all
    render 'index'
  end
  end
  
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def show
    @book = Book.find(params[:id])  
  end
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
  
    if @book.update(book_params)
    flash[:notice] = "successfully!"
    redirect_to book_path(@book.id)
    
  else
     render 'edit'
  end
  end

  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    
    if @book.destroy  # データ（レコード）を削除
    flash[:notice] = "successfully!"
    redirect_to books_path  # 投稿一覧画面へリダイレクト  
  else
    render 'index'
  end
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
  end