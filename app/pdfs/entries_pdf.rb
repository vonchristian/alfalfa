class EntriesPdf < Prawn::Document

def initialize(entries, from_date, to_date, view_context)
  super(margin: 20, page_size: [612, 1008], page_layout: :portrait)
  @entries = entries
  @from_date = from_date
  @to_date = to_date
  @view_context = view_context
  heading

  display_entries_table
end

def price(number)
  @view_context.number_to_currency(number, :unit => "P ")
end


def heading
  text "ALFALFA CONSTRUCTION", style: :bold, size: 10, align: :center
  text "Kiangan, Ifugao", size: 10, align: :center
  move_down 15

  text "JOURNAL ENTRIES FROM #{@from_date.strftime("%B  %e, %Y")} TO #{@to_date.strftime("%B %e, %Y")}", style: :bold, size: 10, align: :center
  move_down 5
  stroke_horizontal_rule
  end


def display_entries_table
  move_down 10
  @entries.entered_on({from_date: @from_date, to_date: @to_date}).each do |entry|
    text " DATE: #{entry.date.strftime("%b %e, %Y")}", size: 9, :color => "0000FF"
    move_down 5
    text "DESCRIPTION:", size: 9, style: :bold
    text "#{entry.description}", size: 9, indent_paragraphs: 20
    move_down 5
    text "CREDITS", size: 9, style: :bold
    entry.credit_amounts.each do |d|
      text "#{d.account.name}: #{price(d.amount)}", size: 9, indent_paragraphs: 20
    end
    move_down 5
    text "DEBITS", size: 9, style: :bold
    entry.debit_amounts.each do |d|
      text "#{d.account.name} #{price(d.amount)}", size: 9, indent_paragraphs: 20
    end
    move_down 5
    text "RECIPIENT / PROJECT", size: 9, style: :bold
    text "#{entry.entriable.try(:name)}", size: 9, indent_paragraphs: 20
    move_down 5
    text "TYPE", size: 9, style: :bold
    text "#{entry.type.sub("Transactions::","").titleize if entry.type}", size: 9, indent_paragraphs: 20
    stroke_horizontal_rule
    move_down 20

  end
end
end
