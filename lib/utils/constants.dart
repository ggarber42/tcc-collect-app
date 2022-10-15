import 'package:flutter/material.dart';

const DropMenuOptions = const [
  DropdownMenuItem(child: Text('Texto'), value: 'text'),
  DropdownMenuItem(child: Text('Lista de Opções'), value: 'radio'),
  DropdownMenuItem(child: Text('Foto'), value: 'img'),
  DropdownMenuItem(child: Text('GPS'), value: 'gps'),
  DropdownMenuItem(child: Text('Data'), value: 'date')
];

const ModelTileMenuOptions = const [
  PopupMenuItem<String>(
    child: const Text('Entradas'),
    value: 'open',
  ),
  PopupMenuItem<String>(
    child: const Text('Editar'),
    value: 'edit',
  ),
  PopupMenuItem<String>(
    child: const Text('Deletar', style: TextStyle(color: Colors.red)),
    value: 'delete',
  ),
];

const EntrielTileMenuOptions = const [
  PopupMenuItem<String>(
    child: const Text('Ver'),
    value: 'open',
  ),
  PopupMenuItem<String>(
    child: const Text('Deletar', style: TextStyle(color: Colors.red)),
    value: 'delete',
  ),
];
