class Admin::Articles::PublishesController < ApplicationController
  layout 'admin'

  before_action :set_article

  def update
    @article.published_at = Time.current unless @article.published_at?
    @article.assign_publish_state

    if @article.valid?
      Article.transaction do
        @article.body = @article.build_body(self)
        if @article.save!
          message = success_message
          flash[:notice] = message
        end
      end
      redirect_to edit_admin_article_path(@article.uuid)
    else
      flash.now[:alert] = 'エラーがあります。確認してください。'

      @article.state = @article.state_was if @article.state_changed?
      render 'admin/articles/edit'
    end
  end

  private

  def set_article
    @article = Article.find_by!(uuid: params[:article_uuid])
  end

  def success_message
    if @article.published?
      '記事を公開しました'
    else
      '記事を公開待ちにしました'
    end
  end
end
