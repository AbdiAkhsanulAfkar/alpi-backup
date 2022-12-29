<div class="container">
    <a href="<?= base_url('admin/pelatih'); ?>" class="btn btn-success">Tambah Data Pelatih</a>
</div>
<div class="card-body">
    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>No</th>
                    <th>NIP</th>
                    <th>Nama</th>
                    <th>JK</th>
                    <th>Alamat</th>
                    <th>No HP</th>
                    <th>Email</th>
                    <!-- <th>Keahlian</th> -->
                    <th>Opsi</th>
                </tr>
            </thead>
            <tbody>
                <?php $no = 1;
                foreach ($users as $d) : ?>
                    <tr>

                        <td><?= $no++ ?></td>
                        <td><?= $d->nip ?></td>
                        <td><?= $d->nama ?></td>
                        <td><?= $d->jk ?></td>
                        <td><?= $d->alamat ?></td>
                        <td><?= $d->no_hp ?></td>
                        <td><?= $d->email ?></td>
                        <td>
                            <a class="btn btn-danger" href="<?= base_url('pelatih/hapus/' . $d->nip) ?>">Hapus</a>
                            <a class="btn btn-warning" href="javascript:void(0)" data-toggle="modal" data-target="#editModal<?= $d->nip ?>">Ubah</a>
                        </td>
                    </tr>
                    <div class="modal fade" id="editModal<?= $d->nip ?>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Ubah Data Pelatih</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <?= form_open('pelatih/ubah/' . $d->nip); ?>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>NIP</label>
                                        <input type="text" name="nip" placeholder="NIP" required class="form-control" value="<?= $d->nip ?>">
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
                                        <label>Alamat</label>
                                        <input type="text" name="alamat" placeholder="Alamat" required class="form-control" value="<?= $d->alamat ?>">
                                    </div>
                                    <div class="form-group">
                                        <label>No. HP</label>
                                        <input type="text" name="no_hp" placeholder="No. HP" required class="form-control" value="<?= $d->no_hp ?>">
                                    </div>
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input type="text" name="email" placeholder="Email" required class="form-control" value="<?= $d->email ?>">
                                    </div>
                                    <!-- <div class="form-group">
                                        <label>Keahlian</label>
                                        <input type="text" name="keahlian" placeholder="Keahlian" required class="form-control" value="">
                                    </div> -->
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