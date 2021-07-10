class Admin::Site::AttachmentsController < ApplicationController
  def destroy
    image = ActiveStorage::Attachment.find(params[:id])
    image.purge
    redirect_to edit_admin_site_path
  end
end
