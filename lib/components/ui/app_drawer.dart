import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokedex/components/ui/drawer_item.dart';
import 'package:pokedex/controllers/user_controller.dart';
import 'package:pokedex/stores/pokemon_store.dart';
import 'package:pokedex/stores/user_preferences_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final UserController _userController = UserController();
  late SharedPreferences _prefs;
  late ImageProvider<Object>? _avatarImage;
  late PokemonStore _pokemonStore;

  @override
  void initState() {
    super.initState();
    _prefs = UserPreferencesStore.getPreferences();
    _updateAvatarImage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pokemonStore = Provider.of<PokemonStore>(context);
  }

  void _updateAvatarImage() {
    final String avatarPath = _prefs.getString('avatar')!;

    ImageProvider<Object>? image;

    if (avatarPath.isNotEmpty) {
      if (kIsWeb) {
        image = NetworkImage(avatarPath);
      } else {
        image = FileImage(File(avatarPath));
      }
    }

    setState(() {
      _avatarImage = image;
    });
  }

  void removeImage() {
    _userController.updateAvatar('');
    _prefs.remove('avatar');
    _updateAvatarImage();
  }

  Future<void> chooseImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: source,
    );

    if (pickedImage != null) {
      // Armazenar a imagem localmente
      final String imagePath = pickedImage.path;

      // Atualizar o Avatar com a nova imagem
      setState(() {
        // Atualizar as preferências do usuário com o caminho da imagem
        _userController.updateAvatar(imagePath);
        _prefs.setString('avatar', imagePath);
        _updateAvatarImage();
      });
    }
  }

  void _showAvatarMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final RelativeRect position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + renderBox.size.height,
      offset.dx + renderBox.size.width,
      offset.dy + renderBox.size.height * 2,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Tirar foto'),
            onTap: () {
              Navigator.pop(context);
              chooseImage(ImageSource.camera);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Selecionar da galeria'),
            onTap: () {
              Navigator.pop(context);
              chooseImage(ImageSource.gallery);
            },
          ),
        ),
        PopupMenuItem(
            child: ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remover imagem'),
                onTap: () {
                  Navigator.pop(context);
                  removeImage();
                }))
      ],
    );
  }

  void logout() {
    _prefs.remove('logged');
    _prefs.remove('id');
    _prefs.remove('nickname');
    _prefs.remove('avatar');
    _pokemonStore.resetStates();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_prefs.getString('nickname') ?? ''),
            accountEmail: const Text(''),
            currentAccountPicture: GestureDetector(
              onTap: () => _showAvatarMenu(context),
              child: CircleAvatar(
                backgroundImage: _avatarImage,
                backgroundColor: Theme.of(context).primaryColor,
                child: Stack(
                  children: [
                    if (_avatarImage == null)
                      const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                  'assets/images/background_drawer.jpeg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          DrawerItem(
            icon: Icons.home,
            title: 'Home',
            subtitle: 'Todos os Pokémons disponíveis',
            onTap: () => Navigator.of(context).pushNamed('/home'),
          ),
          DrawerItem(
            icon: Icons.favorite,
            title: 'Favoritos',
            subtitle: 'Meus Pokémons favoritos',
            onTap: () => Navigator.of(context).pushNamed('/favorites'),
          ),
          DrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            subtitle: 'Finalizar sessão',
            onTap: () => logout(),
          ),
        ],
      ),
    );
  }
}
