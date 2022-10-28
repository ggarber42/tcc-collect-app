import 'package:flutter/material.dart';

const DropMenuOptions = const [
  DropdownMenuItem(child: Text('Texto'), value: 'text'),
  DropdownMenuItem(child: Text('Lista de Opções'), value: 'radio'),
  DropdownMenuItem(child: Text('Foto'), value: 'img'),
  DropdownMenuItem(child: Text('GPS'), value: 'gps'),
  DropdownMenuItem(child: Text('Data'), value: 'date')
];

const DropShareOptions = const [
  DropdownMenuItem(child: Text('Texto'), value: 'text'),
  DropdownMenuItem(child: Text('CSV'), value: 'csv'),
];

const DropShareOptionsAll = const [
  DropdownMenuItem(child: Text('Campos'), value: 'fields'),
  DropdownMenuItem(child: Text('Imagens'), value: 'imgs'),
];

const VALUE_COLLECTION = 'valueCollection';

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

const CollectionTileMenuOptions = const [
  PopupMenuItem<String>(
    child: const Text('Ver'),
    value: 'open',
  ),
  PopupMenuItem<String>(
    child: const Text('Deletar', style: TextStyle(color: Colors.red)),
    value: 'delete',
  ),
];

const ResultTileValueOptions = const [
  PopupMenuItem<String>(
    child: const Text('Ver'),
    value: 'open',
  ),
  PopupMenuItem<String>(
    child: const Text('Compartilhar'),
    value: 'share',
  ),
  PopupMenuItem<String>(
    child: const Text(
      'Backup',
      style: TextStyle(
          color: Colors.blue,
        ),
    ),
    value: 'backup',
  ),
];
