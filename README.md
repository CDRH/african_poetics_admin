# African Poets in the News

## Setup

Prepare database

- `rails db:create`
- `rails db:migrate`
- `rails db:seed`


## Generate Migrations

- `rails g model Poet gender:string nationality:string univ_name:string univ_place:string name:string`
- `rails g model News source:string source_title:string tags:string`
- `rails g migration AddPoetRefToNews poet:references`
  - Modify resulting migration to `null: true` to allow records to not require
    a value for this foreign key


## Change Later

- person "bibliography" will need to be altered in the future to point at works, rather than freeform text field
- university / graduation has degree mixed between university name and graduation date fields! this is difficult to process correctly and should be standardized
- university / graduation often listed as single line with two degrees, would prefer to duplicate (aka: UNL -- 2006 (BA) [new line] UNL -- 2008 (MA))
- do university dates need to be freeform entry (1960s, ranges, etc)? or is YYYY acceptable?
