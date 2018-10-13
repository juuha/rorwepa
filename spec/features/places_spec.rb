require 'rails_helper'

describe "Places" do
    it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    allow(ApixuApi).to receive(:weather_in).with("kumpula").and_return(
      {"last_updated_epoch"=>1539468906,
        "last_updated"=>"2018-10-14 01:15",
        "temp_c"=>10.0,
        "temp_f"=>50.0,
        "is_day"=>0,
        "condition"=>
         {"text"=>"Mist",
          "icon"=>"//cdn.apixu.com/weather/64x64/night/143.png",
          "code"=>1030},
        "wind_mph"=>8.1,
        "wind_kph"=>13.0,
        "wind_degree"=>190,
        "wind_dir"=>"S",
        "pressure_mb"=>1009.0,
        "pressure_in"=>30.3,
        "precip_mm"=>0.2,
        "precip_in"=>0.01,
        "humidity"=>100,
        "cloud"=>100,
        "feelslike_c"=>8.2,
        "feelslike_f"=>46.7,
        "vis_km"=>2.4,
        "vis_miles"=>1.0}       
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if many are returned by the API, all are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("puotila").and_return(
      [ 
        Place.new( name: "Pikkulintu", id: 1 ),
        Place.new( name: "Puotinkrouvi", id: 2 ) 
      ]
    )
    
    allow(ApixuApi).to receive(:weather_in).with("puotila").and_return(
      {"last_updated_epoch"=>1539469810,
        "last_updated"=>"2018-10-14 01:30",
        "temp_c"=>12.0,
        "temp_f"=>53.6,
        "is_day"=>0,
        "condition"=>
         {"text"=>"Clear",
          "icon"=>"//cdn.apixu.com/weather/64x64/night/113.png",
          "code"=>1000},
        "wind_mph"=>12.5,
        "wind_kph"=>20.2,
        "wind_degree"=>190,
        "wind_dir"=>"S",
        "pressure_mb"=>1023.0,
        "pressure_in"=>30.7,
        "precip_mm"=>0.0,
        "precip_in"=>0.0,
        "humidity"=>94,
        "cloud"=>0,
        "feelslike_c"=>9.9,
        "feelslike_f"=>49.8,
        "vis_km"=>7.0,
        "vis_miles"=>4.0}       
    )

    visit places_path
    fill_in('city', with: 'puotila')
    click_button "Search"

    expect(page).to_not have_content "Oljenkorsi"
    expect(page).to have_content "Pikkulintu"
    expect(page).to have_content "Puotinkrouvi"
  end  

  it "if none is returned by the API, use is notified" do
    allow(BeermappingApi).to receive(:places_in).with("tapanila").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'tapanila')
    click_button "Search"

    expect(page).to have_content "No locations in tapanila"
  end  
end