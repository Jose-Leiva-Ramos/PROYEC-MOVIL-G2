import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const header = 'SMART SERVICE SYSTEM.';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: header,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue, // Cambio de color a azul
        backgroundColor: Colors.blueGrey[50],
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      home: InitialPage(),
    );
  }
}

class InitialPage extends StatelessWidget {
  static const welcomeTitle = 'INICIO';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(welcomeTitle),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/fondo.jpg', // Cambiar por la ruta de tu imagen
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'SMART SERVICE SYSTEM',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20.0, // Espacio entre botones
                children: [
                  RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    text: 'Iniciar Sesión',
                    color: Colors.deepPurpleAccent,
                    icon: Icons.login,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15), // Reducción del padding horizontal
                  ),
                  RoundedButton(
                    onPressed: () {
                      // Implementar la lógica para crear una cuenta
                    },
                    text: 'Crear Cuenta',
                    color: Colors.deepPurpleAccent,
                    icon: Icons.create,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15), // Reducción del padding horizontal
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _privilege;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/fondo.jpg', // Cambiar por la ruta de tu imagen
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      '¡BIENVENID@ A SMART SERVICE SYSTEM!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 132), // Aumentar espacio aquí
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Clave',
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Privilegio',
                      prefixIcon: Icon(Icons.security),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    value: _privilege,
                    onChanged: (String? newValue) {
                      _privilege = newValue;
                    },
                    items: <String>['Administrador', 'Empleado'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  RoundedButton(
                    onPressed: () {
                      if (_usernameController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _privilege != null) {
                        if ((_usernameController.text == 'luis' && _passwordController.text == '111' && _privilege == 'Administrador') ||
                            (_usernameController.text == 'juan' && _passwordController.text == '222' && _privilege == 'Empleado')) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage(title: MyApp.header, privilege: _privilege!)),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Usuario, clave o privilegio incorrectos'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Por favor complete todos los campos'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    text: 'Ingresar',
                    color: Colors.blueAccent,
                    icon: Icons.login,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final IconData icon;
  final EdgeInsets padding;

  const RoundedButton({
    required this.onPressed,
    required this.text,
    required this.color,
    required this.icon,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final String privilege;

  MyHomePage({required this.title, required this.privilege});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'STOCK X CATEGORIAS:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage(category: 'PCs de Escritorio')),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.desktop_windows, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'PCs de Escritorio',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage(category: 'Laptops')),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.laptop, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Laptops',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage(category: 'Monitores')),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.monitor, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Monitores',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage(category: 'Periféricos')),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.keyboard, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Periféricos',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      privilege == 'Empleado' ? Icons.work : Icons.admin_panel_settings,
                      size: 30,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '¡Bienvenido!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Usuario: $privilege',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(privilege == 'Empleado' ? Icons.calendar_today : Icons.monetization_on),
              title: Text(privilege == 'Empleado' ? 'REGISTRAR CITA' : 'VER FINANZAS'),
              onTap: () {
                Navigator.pop(context);
                // Implementar la funcionalidad correspondiente
              },
            ),
            ListTile(
              leading: Icon(privilege == 'Empleado' ? Icons.chat : Icons.calendar_today),
              title: Text(privilege == 'Empleado' ? 'VER CHAT DE CONSULTAS' : 'VER CALENDARIO'),
              onTap: () {
                Navigator.pop(context);
                // Implementar la funcionalidad correspondiente
              },
            ),
            if (privilege == 'Administrador') ...[
              ListTile(
                leading: Icon(Icons.bar_chart),
                title: Text('REALIZAR INFORMES'),
                onTap: () {
                  Navigator.pop(context);
                  // Implementar la funcionalidad correspondiente
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text('ESTADO DE LA ENTREGA'),
                onTap: () {
                  Navigator.pop(context);
                  // Implementar la funcionalidad correspondiente
                },
              ),
            ],
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('SALIR'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  final String category;

  ProductsPage({required this.category});

  List<Map<String, dynamic>> products = [];

  void addProducts() {
    if (category == 'PCs de Escritorio') {
      products = [
        {"name": "HP Pavilion", "price": 799},
        {"name": "Dell Inspiron", "price": 699},
        {"name": "Lenovo ThinkCentre", "price": 849},
        {"name": "Acer Aspire", "price": 599},
        {"name": "Asus VivoPC", "price": 749},
      ];
    } else if (category == 'Laptops') {
      products = [
        {"name": "MacBook Air", "price": 999},
        {"name": "Dell XPS 13", "price": 999},
        {"name": "HP Spectre x360", "price": 1249},
        {"name": "Lenovo ThinkPad X1 Carbon", "price": 1429},
        {"name": "Asus ZenBook 14", "price": 899},
      ];
    } else if (category == 'Monitores') {
      products = [
        {"name": "LG UltraGear", "price": 299},
        {"name": "Dell Ultrasharp", "price": 399},
        {"name": "Asus ROG Strix", "price": 499},
        {"name": "Samsung Odyssey", "price": 349},
        {"name": "HP Pavilion", "price": 249},
      ];
    } else if (category == 'Periféricos') {
      products = [
        {"name": "Logitech MX Master 3", "price": 99},
        {"name": "Razer BlackWidow Elite", "price": 129},
        {"name": "Corsair K95 RGB Platinum", "price": 159},
        {"name": "SteelSeries Rival 650", "price": 79},
        {"name": "HyperX Cloud II", "price": 99},
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    addProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(products[index]["name"]),
            trailing: Text('\$${products[index]["price"]}'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Producto agregado al carrito'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

















