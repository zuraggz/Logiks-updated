import 'package:flutter/material.dart';
import 'package:legos/view_models/home_view_model.dart';
import 'package:legos/views/add_lego_view.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddPage,
        backgroundColor: const Color.fromRGBO(7, 100, 176, 1),
        label: Text(
          "Add New Lego",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
      padding: const EdgeInsets.all(12),
      itemCount: _viewModel.allLegosList.length,
      itemBuilder: (context, index) {
        final lego = _viewModel.allLegosList[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Text("${index + 1}"),
            title: Text(lego.name),
            subtitle: Text(lego.id ?? ""),
          ),
        );
      },
    );
  }

  Future<void> _openAddPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddLegoView()),
    );
    _viewModel.fetchAllLegos();
  }
}
