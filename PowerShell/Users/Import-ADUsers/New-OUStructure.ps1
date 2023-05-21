Import-Module ActiveDirectory

New-ADOrganizationalUnit -name Exercises -path "dc=Demo,dc=local"
New-ADOrganizationalUnit -name "valex 2021" -path "ou=Exercises,dc=Demo,dc=local"

$CPTs = "171 CPT", "176 CPT","177 CPT","179 CPT"
foreach ($CPT in $CPTs) {
    New-ADOrganizationalUnit -Name $CPT -path "ou=valex 2021,ou=Exercises,dc=Demo,dc=local"
    New-ADGroup -Name "VAL21 $CPT" -GroupCategory Security -GroupScope Global -Path "ou=$CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local"
    New-ADGroup -Name "VAL21 $CPT Approved" -GroupCategory Security -GroupScope Global -Path "ou=$CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local"
}


ou=171 CPT,
      CN=VAl21 171 CPT,ou=171 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
      CN=VAL21 171 CPT Approved,ou=171 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
   ou=176 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
      CN=VAl21 176 CPT,ou=171 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
      CN=VAL21 176 CPT Approved,ou=171 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
   ou=177 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
      CN=VAl21 177 CPT,ou=171 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
      CN=VAL21 177 CPT Approved,ou=171 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
   ou=179 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
      CN=VAl21 179 CPT,ou=171 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local
      CN=VAL21 179 CPT Approved,ou=171 CPT,ou=valex 2021,ou=Exercises,dc=Demo,dc=local