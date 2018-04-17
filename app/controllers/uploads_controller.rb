class UploadsController < ApplicationController
  def create
     @upload = Upload.new(upload_params)
     @upload.save

     urls = ""
     ids = ""
     count = 0
     length = @upload.images.length
     @upload.images.each do |image|
      count += 1
      urls += image.url
      ids += @upload.id.to_s
      if count != length
        urls += ","
        ids += ","
      end
     end

     respond_to do |format|
       format.json { render :json => {count: length, url: urls, upload_id: ids } }
       # format.json { render :json => {url: @upload.images[0].url, upload_id: @upload.id } }
     end
   end

   def destroy
     @file_name = params[:file_name]
     @upload = Upload.find(params[:id])
     @remember_id = @upload.id
     # @upload.destroy
     # FileUtils.remove_dir("#{Rails.root}/public/uploads/upload/images/#{@remember_id}")
     dir = "#{Rails.root}/public/uploads/upload/images/#{@remember_id}/"
     File.delete(dir + "#{@file_name}")

     # puts "/////////////////// file count "
     # puts Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
     # puts "/////////////////// file count "

     fileCount = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
     if fileCount == 0
       @upload.destroy
       FileUtils.remove_dir("#{Rails.root}/public/uploads/upload/images/#{@remember_id}")
     end

     respond_to do |format|
       format.json { render :json => { status: :ok } }
     end
   end

   private

   def upload_params
     params.require(:upload).permit({images: []})
   end
end
