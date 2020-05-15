    class InvoicesController < ApplicationController
      before_action :set_invoice, only: [:show, :edit, :update, :destroy]

      # GET /invoices
      # GET /invoices.json
      def index 
        @status = params[:status]
        invoices = Invoice.all
        if @status.blank?     
          @invoices_list = invoices
        elsif @status == "pending_bills"
          @invoices_list = invoices.where.not("pending_amount = ?", 0.0 || "0.0")    
        else @status == "collected_bills"
          @invoices_list = invoices.where("pending_amount = ?", 0.0 || "0.0")
        end  
      end

      # GET /invoices/1
      # GET /invoices/1.json
      def show
      end

      # GET /invoices/new
      def new
        @invoice = Invoice.new()
      end

      # GET /invoices/1/edit
      def edit
        @from_page = params[:from_page]
      end

      # POST /invoices
      # POST /invoices.json
      def create
        @invoice = Invoice.new(invoice_params)
        @invoice.pending_amount = @invoice.amount
        @invoice.invoice_date = Date.today

        respond_to do |format|
          if @invoice.save
            format.html { redirect_to invoices_path, notice: 'Invoice was successfully created.' }
            format.json { render :show, status: :created, location: @invoice }
          else
            format.html { render :new }
            format.json { render json: @invoice.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /invoices/1
      # PATCH/PUT /invoices/1.json
      def update
        Collection.create(invoice_id: @invoice.id, reference: @invoice.reference, amount: params[:invoice][:collection_amount], collection_date: Date.today)
        if params[:invoice][:from_page] == "show"
         redirect_to @invoice, notice: 'Collection is successfully added'
       else
        redirect_to invoices_path, notice: 'Collection is successfully added'
      end              
    end

      # DELETE /invoices/1
      # DELETE /invoices/1.json
      def destroy
        @invoice.destroy
        respond_to do |format|
          format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
      
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_invoice
          @invoice = Invoice.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def invoice_params
          params.require(:invoice).permit(:brand_manager, :narration, :invoice_date, :amount, :customer_name, :reference, :pending_amount, :collection_amount)
        end
      end
