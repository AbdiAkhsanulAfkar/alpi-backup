<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<?= base_url('admin') ?>">
        <div class="sidebar-brand-icon rotate-n-15">
            <!-- <i class="fas fa-laugh-wink"></i> -->
        </div>
        <div class="sidebar-brand-text mx-2">Super Admin</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
        <a class="nav-link" href="<?= base_url('admin') ?>">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Management Data
    </div>

    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-fw fa-info-circle"></i>
            <span>Detail</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a class="collapse-item" href="<?= base_url('pelatih/admin') ?>">Pelatih</a>
                <a class="collapse-item" href="<?= base_url('siswa/admin') ?>">Siswa</a>
                <a class="collapse-item" href="<?= base_url('soal') ?>">Soal</a>
            </div>
        </div>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Management User
    </div>


    <!-- Nav Item - Member -->
    <li class="nav-item">
        <a class="nav-link" href="<?= base_url('admin/akunPelatih') ?>">
            <i class="fas fa-fw fa-user"></i>
            <span>Pelatih</span></a>
    </li>

    <!-- Nav Item - Loket -->
    <li class="nav-item">
        <a class="nav-link" href="<?= base_url('admin/akunSiswa') ?>">
            <i class="fas fa-fw fa-user"></i>
            <span>Siswa</span></a>
    </li>
    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Ploting
    </div>
    <li class="nav-item">
        <a class="nav-link" href="<?= base_url('admin/Plotsiswa') ?>">
            <i class="fas fa-fw fa-user"></i>
            <span>Plot Siswa</span></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="<?= base_url('admin/Plotsiswabaru') ?>">
            <i class="fas fa-fw fa-user"></i>
            <span>Plot Siswa Baru</span></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="<?= base_url('admin/Plotwali') ?>">
            <i class="fas fa-fw fa-user"></i>
            <span>Plot Wali Kelas</span></a>
    </li>
    <hr class="sidebar-divider d-none d-md-block">

    <li class="nav-item">
        <a class="nav-link" href="<?= base_url('auth/logout') ?>">
            <i class="fas fa-solid fa-money-bill-1-wave"></i>
            <span>Logout</span></a>
    </li>
    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>


</ul>
<!-- End of Sidebar -->