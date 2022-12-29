<div class="container-fluid">
    <div class="row mt-5">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header text-center">
                    Kelola Data Siswa
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>NISN</th>
                                    <th>Password</th>
                                    <th>NIPD</th>
                                    <th>Nama</th>
                                    <th>Jenis Kelamin</th>
                                    <th>Kelas</th>
                                    <th>jurusan</th>
                                    <th>No HP</th>
                                    <th>Email</th>
                                    <th>Alamat</th>
                                    <th>Opsi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $no = 1;
                                foreach ($siswa as $d) : ?>
                                    <tr>

                                        <td><?= $no++ ?></td>
                                        <td><?= $d->nisn ?></td>
                                        <td><?= $d->password ?></td>
                                        <td><?= $d->nipd ?></td>
                                        <td><?= $d->nama ?></td>
                                        <td><?= $d->jk ?></td>
                                        <td><?= $d->kelas ?></td>
                                        <td><?= $d->jurusan ?></td>
                                        <td><?= $d->no_hp ?></td>
                                        <td><?= $d->email ?></td>
                                        <td><?= $d->alamat ?></td>
                                        <td>
                                            <a class="btn btn-danger" href="<?= base_url('siswa/hapus/' . $d->id) ?>">Hapus</a>
                                            <a class="btn btn-warning" href="javascript:void(0)" data-toggle="modal" data-target="#editModal<?= $d->id ?>">Ubah</a>
                                        </td>
                                    </tr>
                                    <div class="modal fade" id="editModal<?= $d->id ?>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Ubah Data Siswa</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <?= form_open('siswa/ubah/' . $d->id); ?>
                                                <div class="modal-body">
                                                    <div class="form-group">
                                                        <label>NISN</label>
                                                        <input type="text" name="nisn" placeholder="NISN" required class="form-control" value="<?= $d->nisn ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Password</label>
                                                        <input type="text" name="password" placeholder="Password" required class="form-control" value="<?= $d->password ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>NIPD</label>
                                                        <input type="text" name="nipd" placeholder="NIPD" required class="form-control" value="<?= $d->nipd ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>NAMA</label>
                                                        <input type="text" name="nama" placeholder="Nama" required class="form-control" value="<?= $d->nama ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Jenis Kelamin</label>
                                                        <input type="text" name="jk" placeholder="Jenis Kelamin" required class="form-control" value="<?= $d->jk ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Kelas</label>
                                                        <input type="text" name="kelas" placeholder="Kelas" required class="form-control" value="<?= $d->kelas ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Jurusan</label>
                                                        <input type="text" name="jurusan" placeholder="Jurusan" required class="form-control" value="<?= $d->jurusan ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>No. HP</label>
                                                        <input type="text" name="no_hp" placeholder="No. HP" required class="form-control" value="<?= $d->no_hp ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Email</label>
                                                        <input type="text" name="email" placeholder="Email" required class="form-control" value="<?= $d->email ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Alamat</label>
                                                        <input type="text" name="alamat" placeholder="Alamat" required class="form-control" value="<?= $d->alamat ?>">
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                                        <button type="submit" class="btn btn-primary"> <i class="fa fa-pencil"></i> Ubah Data</button>
                                                    </div>
                                                    <?= form_close(); ?>
                                                </div>
                                            </div>
                                        </div>
                                    <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card">
                <div class="card-header text-center bg-success text-white">
                    Tambah Data Siswa
                </div>
                <div class="card-body">
                    <?= form_open_multipart('siswa/insert'); ?>
                    <div class="form-group">
                        <label>NISN</label>
                        <input type="text" name="nisn" placeholder="NISN" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="text" name="password" placeholder="Password" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>NIPD</label>
                        <input type="text" name="nipd" placeholder="NIPD" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>NAMA</label>
                        <input type="text" name="nama" placeholder="Nama" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Jenis Kelamin</label>
                        <input type="text" name="jk" placeholder="Jenis Kelamin" required class="form-control">
                    </div> 
                    <div class="form-group">
                        <label>Kelas</label>
                        <input type="text" name="kelas" placeholder="Kelas" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Jurusan</label>
                        <input type="text" name="jurusan" placeholder="Jurusan" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>No. HP</label>
                        <input type="text" name="no_hp" placeholder="No. HP" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" placeholder="Email" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Alamat</label>
                        <input type="text" name="alamat" placeholder="Alamat" required class="form-control">
                    </div>
                    <button name="submit" class="btn btn-success btn-block"> <i class="fa fa-plus"></i> Tambah Data Siswa</button>
                </div>
                <?= form_close(); ?>
            </div>
        </div>
    </div>
</div>
</div>