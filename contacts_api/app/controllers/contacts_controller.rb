class ContactsController < ApplicationController
  def index
    render json: Contact.all
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save!
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    @contact = Contact.find(params[:id], contact_params)

    if @contact.save!
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    render json: Contact.find(params[:id])
  end

  def destroy
    @contact = Contact.find(params[:id])
    render json: @contact
    Contact.destroy(@contact)
  end

  private

  def contact_params
    params.require(:contact).permit(:user_id, :email, :name)
  end

end
