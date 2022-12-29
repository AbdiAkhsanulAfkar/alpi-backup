<div class="container-fluid">
    <div class="row mt-5">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header text-center">
                    Kelola Akun Siswa
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>NISN</th>
                                    <th>Password</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $no = 1;
                                foreach ($siswa as $p) : ?>
                                    <tr>

                                        <td><?= $no++ ?></td>
                                        <td><?= $p->nipd ?></td>
                                        <td><?= $p->password ?></td>
                                        <td>
                                            <a class="btn btn-danger" href="<?= base_url('siswa/hapusAkun/' . $p->nipd) ?>">Hapus</a>
                                            <a class="btn btn-warning" href="javascript:void(0)" data-toggle="modal" data-target="#editModal<?= $p->nipd ?>">Ubah</a>
                                        </td>
                                    </tr>
                                    <div class="modal fade" id="editModal<?= $p->nipd ?>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Ubah Akun Siswa</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <?= form_open('siswa/ubahAkun/' . $p->nipd); ?>
                                                <div class="modal-body">
                                                    <div class="form-group">
                                                        <label>NIPD</label>
                                                        <input type="text" name="nipd" required class="form-control" value="<?= $p->nipd ?>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Password</label>
                                                        <input type="text" name="password" required class="form-control" value="<?= $p->password ?>">
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
    </div>
</div>
</div>