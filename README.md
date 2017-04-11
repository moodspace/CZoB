# CZoB

The Children’s Zoo of Boston (CZoB) is opening in two days and is in desperate need of help creating a website. After months of intense and mathematically rigorous research, administrators at the zoo have determined that children love pictures of animals. The research also found that children prefer to be able to look at albums of similar animals. They would like animals sorted first by habitat: **land animals**, **aquatic animals**, and **birds**, and second by food preference: **herbivores, omnivores, and carnivores**.


The zoo requests a web platform where they can **upload images of animals**, and children can go to the website to **see those pictures**. Zookeepers (administrators) should be able to upload **images** of animals and tag them with their **name**, **habitat**, and **food preference**. Children should be able to go to the website and request to see albums of animals of any habitat, food preference, or combination of the two.

## Usage

### Test on local computer (Unix / Linux)

- Install Ruby 2.4 and Rails 5.0, [rvm](https://rvm.io/) recommended
- Clone this repo
- Set up a local MySQL (MariaDB) installation with user/pw: root/password
- `cd proj_dir`, `bundle`, `rake db:create`, `rake db:migrate`
- `rails server` starts the server, running at [localhost](http://127.0.0.1:3000/)

### Deploy to Heroku

- Create a new app
- Create a new pipeline and link it with this repo
- Add a MySQL addon, e.g. [JawsDB](https://devcenter.heroku.com/articles/jawsdb)
- Change config variables `DB_HOST`, `DB_NAME`, `DB_PASS`, `DB_USER`, `RACK_ENV=production`, `RAILS_ENV=production`
- In Heroku CLI, run `rake db:create`, `rake db:migrate`
- Deploy

# Future Development

Your job is to create the website for CZoB and make sure it is ready before the zoo opens. While for now this will be a simple website for zookeepers uploading and viewing pictures of animals based on a couple criteria, the zoo has grand plans for many new features the website will have in the future as it grows. These include but are not limited to: more detailed animal categorization, further educational information about the animals, children uploading their own animal photos from their visits, and live webcams of the animals.
