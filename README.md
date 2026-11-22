

Q5 : Un véhicule et une zone changent presque jamais. Si une information change, on remplace simplement l'ancienne valeur par la nouvelle. On n'a pas besoin de garder l'ancienne, donc le Type 1 suffit.

 Q6: La note d'un chauffeur change souvent (par exemple de 4.8 à 3.9). Je veux garder l'ancienne note et la nouvelle, pour savoir comment la note a évolué. Le snapshot fait exactement ça : il garde chaque version avec des dates. Pour un véhicule ou une zone, il n'y a rien à suivre dans le temps, donc un snapshot est inutile.

Q7 : Avec un LEFT JOIN, on garde toutes les courses, même si le chauffeur n'existe pas. Ensuite le test dbt peut voir le problème et échouer. Avec un INNER JOIN, la course avec un chauffeur inconnu disparaît toute seule. Le test ne voit rien et reste vert, donc l'erreur reste cachée. Je veux que ce soit dbt test qui trouve les erreurs.

Q9 : Une macro. Classer une note, c'est une règle de calcul (moins de 4.5, entre 4.5 et 4.8, plus de 4.8) qu'on applique à chaque ligne. Une variable sert seulement à garder une valeur simple, comme la date start_date. Elle ne peut pas contenir une règle.

Q10: Pour le chauffeur 1 :
- avant le changement : 4.80
- après dbt snapshot et un dbt run normal : 4.80
- après dbt run --full-refresh: 3.90

Les anciennes lignes gardent l'ancienne note. fact_rides est incrémental : dbt ajoute seulement les nouvelles courses et ne touche pas aux anciennes. Donc leur note ne change pas. Le flag --full-refresh règle le problème : il supprime la table et la refait entièrement, avec la nouvelle note.

Q12 : J'ai ajouté une course avec le chauffeur 999, qui n'existe pas. Un seul test a échoué : relationships_fact_rides_driver_id__driver_id__ref_stg_drivers_. Il vérifie que chaque chauffeur d'une course existe dans la table des chauffeurs. Les autres tests ont réussi, parce que cette course avait des zones valides et un ride_id unique. Ça marche grâce au LEFT JOIN : la course n'a pas disparu, donc le test l'a trouvée.

Q14: Oui, il est dans le graphe. 

Preuve que ça tourne:

- `dbt run` : `PASS=8 WARN=0 ERROR=0`
- `dbt test` : `PASS=12 WARN=0 ERROR=0`
