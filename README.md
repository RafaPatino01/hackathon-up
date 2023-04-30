
# ComparaBus
- **ComparaBus** es una app de consulta de horarios de autobuses en México.
- Hacemos uso de *web scraping* para revisar las rutas de las distintas empresas de movilidad del país.

## Documento escrito
- ⚡️ Revisa el [documento escrito del proyecto](https://rafaelpatinogoji.notion.site/ComparaBus-494bd370caab470f8ca5fc322c97b5dc).
- Ahí añadimos detalles importantes sobre nuestro proyecto.

## Arquitectura de nuestra app
<img src="https://i.ibb.co/wwhmsv3/image.png" style="width: 100%">

## Back-end (NodeJS) 
- El backend está deployado en una instancia de *Huawei Cloud*.
<img src="https://i.ibb.co/DQ6NPV1/Screen-Shot-2023-04-30-at-12-30-58-p-m.png" style="width: 100%">

### API Endpoints 
server IP: 122.8.178.68:3000 <br>

- **/post_user** `params: { key: user_name,  value: <string> },{ key: password,  value: <string> }` <br /> Sirve para dar de alta un usuario en la base <br /> <br />
- **/login** `params: { key: user_name,  value: <string> },{ key: password,  value: <string> }` <br /> Realiza login en la app <br /> <br /> 
- **/scraper** `params: { key: link,  value: <string> }` <br /> Ingresas el URL de la página a realizar web scrapping, procesa y devuelve los resultados de la búsqueda <br /> <br /> 
- **/get_terminales** `params: { key: <none>,  value: <none> }` <br /> Realiza consulta a DB MySQL sobre las terminales y entrega los resultados<br /> <br />


## Base de datos (MySQL) 
- La base está deployada en una instancia de *Huawei Cloud*.
- Server IP: 110.238.83.6:3306. 
<img src="https://i.ibb.co/dLCtwBR/rds.png" style="width: 100%">
