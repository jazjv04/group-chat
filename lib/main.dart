import 'package:flutter/material.dart';

void main() {
  runApp(const VideoCallApp());
}

class VideoCallApp extends StatelessWidget {
  const VideoCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const VideoCallHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class VideoCallHomePage extends StatefulWidget {
  const VideoCallHomePage({super.key});

  @override
  State<VideoCallHomePage> createState() => _VideoCallHomePageState();
}

class _VideoCallHomePageState extends State<VideoCallHomePage> {
  int _currentIndex = 0;

  // Lista de URLs de imágenes
  final List<String> profileImages = [
    'https://fastly.picsum.photos/id/64/4326/2884.jpg?hmac=9_SzX666YRpR_fOyYStXpfSiJ_edO3ghlSRnH2w09Kg',
    'https://fastly.picsum.photos/id/342/2896/1944.jpg?hmac=_2cYDHi2iG1XY53gvXOrhrEWIP5R5OJlP7ySYYCA0QA',
    'https://fastly.picsum.photos/id/338/2000/1333.jpg?hmac=-sTSfHkgHcFg1Jdut1v8HTVl9S1cyeMQ0OY_8dj30fY',
    'https://fastly.picsum.photos/id/342/2896/1944.jpg?hmac=_2cYDHi2iG1XY53gvXOrhrEWIP5R5OJlP7ySYYCA0QA'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Group Chatting', style: TextStyle(color: Colors.white)),
            Text('Chat with your friends',
            style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => _showSnackbar('Configuración'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menú', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                setState(() => _currentIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Editar Perfil'),
              onTap: () {
                _showSnackbar('Editar Perfil');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Mis Amigos'),
              onTap: () {
                _showSnackbar('Mis Amigos');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _currentIndex == 3
      ? const ProfileScreen()
      : Stack(
        children: [
          //Grid de imágenes
          GridView.count(
            crossAxisCount: 2,//Columnas
            childAspectRatio: 1.0,
            padding: const EdgeInsets.all(8),
            children: profileImages.map((imageUrl) {//Usa las URLs de las imágenes
              return Card(
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ClipRRect(//recorta la imagen
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
          
          // Controles de llamada
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón de video
                FloatingActionButton(
                  heroTag: 'video',
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    _showSnackbar('Video encendido');
                  },
                  child: Icon(Icons.videocam),
                ),
                const SizedBox(width: 20),
                
                // Botón de micrófono
                FloatingActionButton(
                  heroTag: 'mic',
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    _showSnackbar( 'Micrófono activado');
                  },
                  child: Icon(Icons.mic),
                ),
                const SizedBox(width: 20),
                
                // Botón para finalizar llamada
                FloatingActionButton(
                  heroTag: 'call',
                  onPressed: () => _showSnackbar('Llamada finalizada'),
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
            _showSnackbar(['Dashboard', 'Inicio', 'Chat', 'Perfil'][index]);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            backgroundColor: Colors.blue,
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://fastly.picsum.photos/id/64/4326/2884.jpg?hmac=9_SzX666YRpR_fOyYStXpfSiJ_edO3ghlSRnH2w09Kg'),
            ),
            const SizedBox(height: 20),
            const Text('Jazmin  Fuentes', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            const Text('id.4-823-2320'),
            const Text('jaz004@ejemplo.com'),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}