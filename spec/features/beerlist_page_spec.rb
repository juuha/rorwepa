require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :selenium do | app |
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: { args: ['headless', 'disable-gpu'] }
      )

      Capybara::Selenium::Driver.new app,
        browser: :chrome,
        desired_capabilities: capabilities
    end
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name:"Koff")
    @brewery2 = FactoryBot.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name:"Ayinger")
    @beer1 = FactoryBot.create(:beer, name:"Nikolai", brewery: @brewery1, style:"Lager")
    @beer2 = FactoryBot.create(:beer, name:"Fastenbier", brewery:@brewery2, style:"Rauchbier")
    @beer3 = FactoryBot.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:"Weizen")
  end

  it "shows one knows beer", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end

  it "orders beers alphabetically", js:true do
    visit beerlist_path
    expect(find('table').find('tr:nth-child(2)')).to have_content "Fastenbier"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Lechte Weisse"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Nikolai"
  end

  it "orders beers by style after clicking Style", js:true do
    visit beerlist_path
    click_link "Style"
    expect(find('table').find('tr:nth-child(2)')).to have_content "Lager"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Rauchbier"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Weizen"
  end

  it "orders beers by brewery after clicking Brewery", js:true do
    visit beerlist_path
    click_link "Brewery"
    expect(find('table').find('tr:nth-child(2)')).to have_content "Ayinger"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Koff"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Schlenkerla"
  end

end
