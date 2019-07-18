require_relative '../lib/app_mairie.rb'


describe 'it returns the correct email of the designed city' do
  # check some values
  it 'is correct email for Aix en Provence?' do
    expect(get_townhall_email("http://www.annuaire-des-mairies.com/13/aix-en-provence.html")).to eq("communication@mairie-aixenprovence.fr")
    end
  it 'is correct email for Marseille 13008?' do
    expect(get_townhall_email("http://www.annuaire-des-mairies.com/13/marseille-secteur-08.html")).to eq("mairie-info15-16@mairie-marseille.fr")
    end
  it 'is correct email for Peypin?' do
    expect(get_townhall_email("http://www.annuaire-des-mairies.com/13/peypin.html")).to eq("mairie.peypin@orange.fr")
    end
end


describe 'it returns a hash with cities names and emails' do
  # check it does not return nil
  it 'returns not nil?' do
    expect(get_townhall_urls).to be
    end
  # check it return a hash larger than 50 values
  it 'contains at least 50 values?' do
    expect(get_townhall_urls.length).to be > 50
    end 
  # check some values for KEYS
  # "PLAN DE CUQUES"=>"mairie@plandecuques.fr"
  it 'contains key "PLAN DE CUQUES"?' do
    expect(get_townhall_urls.has_key?("PLAN DE CUQUES")).to eq(true)
    end
  # "VERNEGUES"=>"mairie.vernegues@wanadoo.fr"
  it 'contains key "VERNEGUES"?' do
    expect(get_townhall_urls.has_key?("VERNEGUES")).to eq(true)
    end
  # check some values for VALUES
  # "PLAN DE CUQUES"=>"mairie@plandecuques.fr"
  it 'contains value "mairie@plandecuques.fr"?' do
    expect(get_townhall_urls.has_value?("mairie@plandecuques.fr")).to eq(true)
    end
  # "LA PENNE SUR HUVEAUNE"=>"communication@mairie-lapennesurhuveaune.fr"
  it 'contains value "communication@mairie-lapennesurhuveaune.fr"?' do
    expect(get_townhall_urls.has_value?("communication@mairie-lapennesurhuveaune.fr")).to eq(true)
    end


end