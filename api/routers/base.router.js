const expressRouter = require("express").Router;

class BaseRouter {

/*
    Récupération des modules

    Permet de recuperer le nom du router appelé :Auth

    Replace du mot Router par vide

    Concatenation de auth avec le controller : auth.controller

    Création de la class pour faire appel à la fonction login
  */


    constructor(withRoutesInitialization = true) {
      this.router = expressRouter();
      this.name = this.constructor.name.replace(`Router`, ``);
      const ControllerClass = require(`../controllers/${this.name.unCamelize()}.controller`);
      this.controller = new ControllerClass();
      // withRoutesInitialization ? this.initializeRoutes() : null;
    }
  
    // initializeRoutes = () => {
    //   console.log(`initializing all routes for ${this.name}`);
      
    //   this.router.all("/:action", async (req, res) => {
    //       if(!this.controller[req.params.action]) res.status(400).json(null);
    //       //method
          
    //       const response = await this.controller[req.params.action](req, res);
    //       res.status(response.status || 200).json(response);
    //   });
    // }
  
  }
  module.exports = BaseRouter;
    // constructor()
    // {
    //   this.router = expressRouter(); //initialise le router d'express//
    //   this.name = this.constructor.name.replace(Router, `);

      //?on crée le controler qui correspond  en fontion du nom

    //   Auth = auth.controller
    //   const ControllerClass = require(../controllers/${this.name.unCamelize()}.controller`);
    //   this.controller = new ControllerClass();
    // }
  // }
// module.exports = BaseRouter;
