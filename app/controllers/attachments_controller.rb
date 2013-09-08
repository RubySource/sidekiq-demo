class AttachmentsController < ApplicationController

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.create(params[:attachment])
 
    #here's we mix in some Sidekiq
    PagecountWorker.perform_async(@attachment.id)  
  end

  def show
    a = Attachment.find(params[:id])

    #now, we perform nearly the same operation
    #but, synchronously, notice the call is 
    #completely different.
    a.save_page_count

    @page_count = a.page_count
  end
end
