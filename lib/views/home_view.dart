import 'package:flutter/material.dart';
import 'package:legos/view_models/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchAllLegos();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(7, 100, 176, 1),
        title: const Text(
          "All Legos Available",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) => _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_viewModel.hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Couldn't load legos"),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _viewModel.fetchAllLegos,
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    if (_viewModel.allLegosList.isEmpty) {
      return const Center(child: Text("No legos yet"));
    }

    return ListView.builder(
      itemCount: _viewModel.allLegosList.length,
      itemBuilder: (context, index) {
        final lego = _viewModel.allLegosList[index];
        return ListTile(
          leading: Text("${index + 1}"),
          title: Text(lego.name),
          subtitle: Text(lego.id ?? ""),
        );
      },
    );
  }
}
