## How to name your models

There has been a lot of confusing posts on how to name your models?
I tried using the source__target style but found it to be too painful to continue.
This also breaks if you have a target that combines multiple sources


I would recommend simple short names to keep references but at the same time keeping it unique across the whole project.

Try not to name two models the same file as there is a lot of references to existing files involved.

The prefix still seems to be working to keep the model names and files unique.


select *
from a_big_table

using targets like prod or dev to limit the number of records to copy  

-- limit the amount of data queried in dev
{% if target.name != 'prod' %}
where created_at > date_trunc('month', current_date)
{% endif %}

