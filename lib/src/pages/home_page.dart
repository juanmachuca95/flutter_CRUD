import 'package:flutter/material.dart';
//import 'package:fluttercrud/src/bloc/provider.dart';
import 'package:fluttercrud/src/models/producto_model.dart';
import 'package:fluttercrud/src/providers/productos_provider.dart';


class HomePage extends StatelessWidget {

  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    //final bloc = Provider.of(context);

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Home'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context) 

    );
  }


   Widget _crearListado(){
    //print(productosProvider.cargarProductos());

    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      
      builder: (BuildContext context , AsyncSnapshot<List<ProductoModel>> snapshot){
        if( snapshot.hasData ) {
          
          final productos = snapshot.data;
          print(productos);

          return ListView.builder(
            
            itemCount: productos.length,
            
            itemBuilder: (context, i) => _crearItem(context, productos[i])

          );

        }else{

          return Center( child: CircularProgressIndicator());

        }

      }
    );
  }


  Widget _crearItem(BuildContext context, ProductoModel producto){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direccion ){

        productosProvider.borrarProducto(producto.id);
              
      },
      child: ListTile(
        title: Text('${ producto.titulo } ${ producto.valor }'),
        subtitle: Text(' ${ producto.id } '),
        onTap: () => Navigator.pushNamed( context, 'producto')
      ),
    );

  }


  Widget _crearBoton(BuildContext context){

    return FloatingActionButton(
      child: Icon( Icons.add ),
      onPressed: () => Navigator.pushNamed(context, 'producto')
    );

  }

}

